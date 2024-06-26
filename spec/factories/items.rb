FactoryBot.define do
  factory :item do
    association :user

    item_name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 1, to: 10) }
    item_condition_id { Faker::Number.between(from: 1, to: 6) }
    delivery_price_id { Faker::Number.between(from: 1, to: 2) }
    region_id { Faker::Number.between(from: 1, to: 47) }
    delivery_time_id { Faker::Number.between(from: 1, to: 3) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |item|
      item.image.attach(io: File.open('public/test_image.png'), filename: 'test_image.png')
    end
  end
end
