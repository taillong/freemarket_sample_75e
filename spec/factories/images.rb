FactoryBot.define do
  factory :image do
    images   {File.open("#{Rails.root}/public/images/test_image.jpg")}
  end
end
