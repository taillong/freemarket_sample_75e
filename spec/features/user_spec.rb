##未完成##

require 'rails_helper'

feature 'user', type: :feature do

  scenario 'usee登録' do
    expect {
      visit new_user_registration_path
      expect(page).to have_content '会員情報'
      fill_in 'field__input__nickname', with: "yama"
      fill_in 'field__input__email', with: "abcd@eg.com"
      fill_in "field__input__password", with: "123456q"
      fill_in "field__input__password_confirmation", with: "123456q"
      find('input[type="submit"]').click
      expect(current_path).to eq user_registration_path
      expect(page).to have_content("本人確認")
      fill_in "person_info_family_name", with: "山田"
      fill_in "person_info_first_name", with: "綾"
      fill_in "person_info_family_kana", with: "やまだ"
      fill_in "person_info_first_kana", with: "あや"
      select 2000, from: 'person_info_birth_date_1i'
      select 01, from: 'person_info_birth_date_2i'
      select 31, from: 'person_info_birth_date_3i'
      click_on("次に進む")
      expect(current_path).to eq person_infos_path
      expect(page).to have_content("商品送付先住所情報")
      fill_in "address_family_name", with: "山田"
      fill_in "address_first_name", with: "綾"
      fill_in "address_family_kana", with: "やまだ"
      fill_in "address_first_kana", with: "あや"
      fill_in "address_zipcode", with: "123-4567"
      select "青森県", from: 'address_prefecture_id'
      fill_in "address_city", with: "青山1-1"
      fill_in "address_apartment", with: "柳ビル103"
      fill_in "address_tell", with: "09012345678"
      find('input[type="submit"]').click
      #binding.pry
      #save_and_open_page
    }.to change(User, :count).by(1)
  end 
end