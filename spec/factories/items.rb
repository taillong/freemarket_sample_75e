FactoryBot.define do

  factory :item do
    name             {"ドラゴンクエスト3"}
    explanation      {"そして伝説へ！まじで神ゲー"}
    condition_id     {"1"}
    delivery_fee_id  {"1"}
    duration_id      {"1"}
    price            {"1200"}
    prefecture_id    {"22"}
    brand_id         {"2"}
    category_id      {"1203"}
    seller
    images   {File.open("#{Rails.root}/public/images/test_image.jpg")}

  end

end