class UserService
  def list
    User.order('customer_name DESC')
  end
end