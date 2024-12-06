require 'sinatra'
require 'json'
require 'sqlite3'
require_relative 'my_user_model'

# Initialize SQLite3 database
DB = SQLite3::Database.new 'db.sql'

# Enable sessions and cookies
enable :sessions
set :bind, '0.0.0.0'
set :port, 8080

# Display all users
get '/users' do
  users = User.all  # Fetch all users from the database
  erb :index, locals: { users: users }  # Render the index.erb file
end

# Show a specific user
get '/users/:id' do
  user = User.find(params[:id])  # Find a user by ID from the database
  erb :show, locals: { user: user }  # Render the show.erb file with user details
end

# POST on /users - Create a new user
post '/users' do
  user_info = {
    firstname: params[:firstname],
    lastname: params[:lastname],
    age: params[:age],
    password: params[:password],
    email: params[:email]
  }
  user_id = User.create(user_info)  # Create user in the database
  user = User.find(user_id)  # Find the newly created user
  user.delete(:password)  # Remove the password from the response for security
  user.to_json  # Send the user data back in JSON format
end

# POST on /sign_in - Sign in a user and create a session
post '/sign_in' do
  email = params[:email]
  password = params[:password]
  result = DB.execute("SELECT * FROM users WHERE email = ? AND password = ?", [email, password])

  if result.empty?
    status 401
    { message: 'Invalid credentials' }.to_json
  else
    user = result.first
    session[:user_id] = user[0]  # Store the user_id in session
    user_hash = {
      id: user[0],
      firstname: user[1],
      lastname: user[2],
      age: user[3],
      email: user[5]
    }
    user_hash.delete(:password)  # Remove the password for security
    user_hash.to_json  # Return user data (without password)
  end
end

# PUT on /users - Update user password (requires user to be logged in)
put '/users' do
  if session[:user_id].nil?
    status 401
    return { message: 'You must be logged in to update your password' }.to_json
  end

  new_password = params[:password]
  user = User.update(session[:user_id], 'password', new_password)  # Update password for logged-in user
  user.delete(:password)  # Remove password from response
  user.to_json  # Send back the updated user data
end

# DELETE on /sign_out - Sign out the current user
delete '/sign_out' do
  session.clear  # Clear the session (log out)
  status 204  # No content (success)
end

# DELETE on /users/:id - Delete a user by ID (admin or authorized)
delete '/users/:id' do
  user_id = params[:id]
  DB.execute("DELETE FROM users WHERE id = ?", [user_id])  # Delete user from the database
  "User with ID #{user_id} has been deleted."
end

# DELETE on /users - Destroy the current user (requires user to be logged in)
delete '/users' do
  if session[:user_id].nil?
    status 401
    return { message: 'You must be logged in to delete your account' }.to_json
  end

  User.destroy(session[:user_id])  # Delete the logged-in user's account
  session.clear  # Log out the user by clearing the session
  status 204  # No content (success)
end

# Render HTML page with user list
get '/' do
  users = User.all  # Fetch all users from the database
  erb :index, locals: { users: users }  # Render the index page with users list
end
