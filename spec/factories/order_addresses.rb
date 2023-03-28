FactoryBot.define do
  factory :order_address do
    token { 'tok_abcdefghijk00000000000000000' }
    post_code { '123-1234' }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    delivery_city { '横浜市緑区' }
    delivery_address { '青山1-1-1' }
    delivery_building { '柳ビル103' }
    telephone_number { '09012341234' }
    association :user
    association :item
  end
end
