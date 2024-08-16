# WALLET STOCKS API 

Things you may want to cover:

* Ruby version

* Configuration

* Database  :
  - Create database transactions with : `rake db:create`
    'transactions_dev' for development
    'transactions_test' for staging
    'transactions' for production
    
  - run `rails db:migrate` for create tables
  - run `rake db:seed` for first data

* How to run :
  - open postman for better API testing
  Login :

  ```
    curl --location 'http://127.0.0.1:3000/login' \
    --header 'Content-Type: application/json' \
    --data '{
        "username": "user1",
        "password": "password123"
    }'
  ```
  sample output :
  ```
 {
    "status": "200",
    "message": "Success",
    "token": "xx02xxxx37b6dxx"
 }
  ```
  copy token, and test to transaction : 
  

