FactoryBot.define do
  factory :item do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 10) }
    category_id           { 2 }
    item_condition_id     { 2 }
    postage_payer_id      { 2 }
    prefecture_id         { 2 }
    preparation_day_id    { 2 }
    price                 { 1000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/images/f_180_topimg.jpg'), filename: 'f_180_topimg.jpg')
    end
  end
end
