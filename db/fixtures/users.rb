for user in ['admin' , 'user']
  User.seed do |t|
    t.username = user
    t.password = 'password'
    t.email = "#{user}@email.com"
  end
end
