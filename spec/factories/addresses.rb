FactoryBot.define do
  factory :address do
    family_name      {"山田"}
    first_name       {"綾"}
    family_kana      {"やまだ"}
    first_kana       {"あや"}
    prefecture_id    {"1"}
    zipcode          {"123-4567"}
    city             {Faker::Address.city}
    street           {Faker::Address.street_address}
    apartment        {"ビル111"}
    tell             {"09012345678"}
    user
  end
end
