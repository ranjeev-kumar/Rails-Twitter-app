FactoryGirl.define do
  factory :user, class: 'User' do
    fname 'normal'
    lname 'user'
    dob '01/01/1990'
    gender 'male'
    sequence(:email) { |n| "normaluser+#{n}@normaluser.com" }
    password '123456789'
  end
end