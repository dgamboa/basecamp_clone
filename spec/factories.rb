FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'pizzas'
    password_confirmation 'pizzas'
  end
end