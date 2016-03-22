FactoryGirl.define do
  factory :tweet, class: 'Tweet' do
    body 'This tweet is only for testing.'
    user
  end
end