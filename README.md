# Welcome to My Users App
***

## Task
The task of this project is to build a simple User Management App that handles basic CRUD (Create, Read, Update, Delete) operations. The app will be developed using Ruby, Sinatra, and an SQLite3 database. Users will be able to create new accounts, view all users, update their profiles, and delete their accounts via the app's interface and API.

## Description
This project provides a simple web application where users can perform CRUD operations on user data, such as adding new users, viewing a list of users, editing user details, and deleting users. The app is built using the MVC (Model View Controller) architecture:
1. Model: Manages data storage and interaction with the SQLite3 database.
2. View: Displays the user interface (HTML and ERB templates).
3. Controller: Handles routes and requests from users, communicating between the view and the model.

## Installation
Clone this repository:
git clone https://github.com/your_username/my_users_app.git
cd my_users_app
Install the required dependencies:
bundle install
Set up the SQLite3 database:
ruby db_setup.rb
Start the application:
ruby app.rb

## Usage
After starting the app, you can interact with the following routes:

Create a new user:
Via command-line (cURL):

curl -X POST -i http://localhost:8080/users -d "firstname=John" -d "lastname=Doe" -d "age=25" -d "password=secret" -d "email=john.doe@example.com"
View all users:
Open your browser and visit:

http://localhost:8080/users
Update a user:
Via command-line (cURL):

curl -X PUT -i http://localhost:8080/users/1 -d "firstname=John" -d "lastname=Smith"
Delete a user:
Via command-line (cURL):

curl -X DELETE -i http://localhost:8080/users/1
Features
User-friendly web interface for managing users.
Full CRUD functionality (Create, Read, Update, Delete) via both web interface and API.
Data persistence using SQLite3.
Password handling with masked display in the UI.


and for your database you open another terminal and run the following command:
sqlite3 db.sql
SELECT *  FROM user;
and you can view your data that is stored.
```
./my_project User app
```

### The Core Team
Hillary Emmanuel


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px' /></span>
