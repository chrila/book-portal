require 'faker'

100.times do
  Book.create!(title: Faker::Book.title, author: Faker::Book.author, user: nil);
end
