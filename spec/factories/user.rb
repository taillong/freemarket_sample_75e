FactoryBot.define do 
  factory :user do
    password = Faker::Internet.password(min_length: 7)
    nickname {Faker::Internet.username}
    email    {Faker::Internet.free_email}
    password {"123456q"}
    password_confirmation {"123456q"}
  end
end