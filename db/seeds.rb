ActiveRecord::Base.transaction do
  puts "====Start Seed====" 
  # Clear existing data to avoid duplicates from first launch
  TeamMember.delete_all
  UserLogin.delete_all
  User.delete_all
  Team.delete_all
  Stock.delete_all

  # Create Users
  puts "create 3 Users"
  user1 = User.create(customer_name: 'Roronoa Zoro', email: 'zoro@onepiece.com')
  user2 =User.create(customer_name: 'Sanji', email: 'sanji@onepiece.com')
  user3 =User.create(customer_name: 'Lewandoski', email: 'lws@gmail.com')
  
  puts " 1- #{user1.customer_name}"
  puts " 2- #{user3.customer_name}"
  puts " 3- #{user3.customer_name}"
  puts ""
  # # Create Logins for Users
  UserLogin.create!(loginable: user1, username: 'user1', password: 'password123')
  UserLogin.create!(loginable: user2, username: 'user2', password: 'password123')
  UserLogin.create!(loginable: user3, username: 'user3', password: 'password123')
  #=================================================================================
  # Create Teams
  puts "create 1 team with member ( #{user1.customer_name} and  #{user2.customer_name}  )"
  team1 = Team.create(team_name: 'pirates team', email: 'zoro@onepiece.com')
  # # Create Team Members
  puts " 1- #{team1.team_name}"
  puts ""
  TeamMember.create!(user: user1, team: team1, is_lead: 1)
  TeamMember.create!(user: user2, team: team1)

  # # Create Logins for Team
  UserLogin.create!(loginable: team1, username: 'team1', password: 'password123')
  # #=================================================================================
  # # Create Stocks
  puts "create sample stock base on rapid-API"
  stock1 = Stock.create!(stock_name: 'APOLLOHOSPEQN', symbol: 'APOLLOHOSP')
  stock2 = Stock.create!(stock_name: 'ITCEQN', symbol: 'ITC')
  stock3 = Stock.create!(stock_name: 'TITANEQN', symbol: 'TITAN')
  puts " 1- #{stock1.stock_name}"
  puts " 2- #{stock2.stock_name}"
  puts " 3- #{stock3.stock_name}"
  puts ""
  # # Create Logins for Stocks
  UserLogin.create!(loginable: stock1, username: 'stock1', password: 'password123')
  UserLogin.create!(loginable: stock2, username: 'stock2', password: 'password123')
  UserLogin.create!(loginable: stock3, username: 'stock3', password: 'password123')
  #=================================================================================
  #
ActiveRecord::Base.connection.commit_db_transaction
puts "====Seed data successfully created!===="  
rescue StandardError => e
  # Rollback in case of any error
  ActiveRecord::Base.connection.rollback_db_transaction
  raise e
end