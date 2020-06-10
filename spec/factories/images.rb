FactoryBot.define do
  factory :images do
    src   {File.open("#{Rails.root}/public/images/test_image.jpg")}
  end
end
