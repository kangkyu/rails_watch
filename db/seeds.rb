User.delete_all
user = User.create!(username: 'samesame', password: 'samesame', password_confirmation: 'samesame')

Status.delete_all
Task.delete_all
(1..417).each do |num|
  task = Task.create!(episode: num, date: Time.new + num.days)
  task.statuses.create(user: user, completed: false)
end
