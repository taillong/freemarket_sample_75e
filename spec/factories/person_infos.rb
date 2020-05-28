FactoryBot.define do
  factory :person_info do
    family_name   {"山田"}
    first_name    {"綾"}
    family_kana   {"やまだ"}
    first_kana    {"あや"}
    birth_date    {Faker::Date.birthday}
    user
  end
end
