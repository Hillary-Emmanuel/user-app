require 'sqlite3'

class User
  DB = SQLite3::Database.new 'db.sql'

  # Create users table if it doesn't exist
  DB.execute <<-SQL
    CREATE TABLE IF NOT EXISTS users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      firstname TEXT,
      lastname TEXT,
      age INTEGER,
      password TEXT,
      email TEXT
    );
  SQL

  def self.create(user_info)
    DB.execute("INSERT INTO users (firstname, lastname, age, password, email)
                VALUES (?, ?, ?, ?, ?)",
               [user_info[:firstname], user_info[:lastname], user_info[:age],
                user_info[:password], user_info[:email]])

    # Return the id of the newly created user
    DB.last_insert_row_id
  end

  def self.find(user_id)
    result = DB.execute("SELECT * FROM users WHERE id = ?", [user_id])
    return nil if result.empty?
    
    # Return user data as a hash
    row = result.first
    {
      id: row[0],
      firstname: row[1],
      lastname: row[2],
      age: row[3],
      password: row[4],
      email: row[5]
    }
  end

  def self.all
    result = DB.execute("SELECT * FROM users")
    users = {}
    
    result.each do |row|
      users[row[0]] = {
        id: row[0],
        firstname: row[1],
        lastname: row[2],
        age: row[3],
        password: row[4],
        email: row[5]
      }
    end
    users
  end

  def self.update(user_id, attribute, value)
    DB.execute("UPDATE users SET #{attribute} = ? WHERE id = ?", [value, user_id])
    find(user_id)  # Return the updated user
  end

  def self.destroy(user_id)
    DB.execute("DELETE FROM users WHERE id = ?", [user_id])
  end
end
