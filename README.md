# WALLET STOCKS API 

Things you may want to cover:

* Ruby version 3.2.2

* Configuration, for first download from repository, run `bundle install`

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

  copy token, paste to Authorization and test to 

  Transaction 
  ==============================================
  <ul>
  <li>deposit :</li> 

  ```
  curl --location 'http://127.0.0.1:3000/api/transaction/deposit' \
  --header 'Content-Type: application/json' \
  --header 'Authorization: Bearer 61020586c9b4337b6dc1' \
  --data '{
      "amount": 40000
  }'
  ```

  <li>transfer (send/receive) :</li>
  
  ```
    curl --location 'http://127.0.0.1:3000/api/transaction/transfer' \
        --header 'Content-Type: application/json' \
        --header 'Authorization: Bearer 61020586c9b4337b6dc1' \
        --data '{
            "amount": 10000,
            "target_wallet_id": 13
        }'
  ```

    <li>withdraw :</li>
  
  ```
    curl --location 'http://127.0.0.1:3000/api/transaction/withdraw' \
      --header 'Content-Type: application/json' \
      --header 'Authorization: Bearer 61020586c9b4337b6dc1' \
      --data '{
          "amount": 10000
      }'

  ```

  <li>purchase stock (buy/sell) :</li>

  
  ```
    curl --location 'http://127.0.0.1:3000/api/transaction/purchase' \
      --header 'Content-Type: application/json' \
      --data '{
          "lot": 1,
          "symbol": "ITC"
      }'
      
  ```

</ul>


list 
==============================================

<ul>
<li>
    User list :

  
  ```
curl --location 'http://127.0.0.1:3000/api/user#list' \
--header 'Authorization: Bearer 61020586c9b4337b6dc1'
      
  ```
</li>
<li>
    User Login list :

  
  ```
curl --location 'http://127.0.0.1:3000/api/user_login#list' \
--header 'Authorization: Bearer 61020586c9b4337b6dc1'
  ```
</li>
</ul>