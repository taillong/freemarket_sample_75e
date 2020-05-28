FactoryBot.define do
  factory :person_info do
    family_name   {"山田"}
    first_name    {"綾"}
    family_kana   {"やまだ"}
    first_kana    {"あや"}
    birth_date    {"2000-01-01"}
    user
  end
end
