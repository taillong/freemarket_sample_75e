##未完成##

require 'rails_helper'

describe Users::RegistrationsController  do
  let(:user) { create(:user) }
  #before do
    
  #end
 # let(:person_info) { {user_id: user.id, person_info: attributes_for(:person_info) }}

  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      request.env["devise.mapping"] = Devise.mappings[:user]
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
    end

    it "バリデーションを通らなかった場合new.html.hamlに偏移する" do
      post :create
      no_user = build(:user, email: nil)
      if no_user.valid?
        expect(response).to render_template :new
      end
    end

    context "有効なデータの場合"  do
      subject {
        user = attributes_for(:user)
        post :create, params: { user: user },
                        session: {
                          devise_regist_data: user
                        }
      }
    

      it "new_person_info.html.hamlに偏移すること" do
        subject
        expect(response).to render_template :new_person_info
      end
    end
  end

  describe 'POST #create_person_info' do
    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      user_params = attributes_for(:user)
      post :create, params: { user: user_params },
                        session: {
                          devise_regist_data: user_params
                        }
    end

    it "無効なデータの場合" do
      #post :create_person_info
      #binding.pry
      no_person = build(:person_info, family_name: nil)
      if no_person.valid?
        expect(response).to render_template :new_person_info
      end
    end

    context "有効なデータの場合"  do
      subject {
        person_info = attributes_for(:person_info)
        post :create_person_info, params: { person_info: person_info},
                        session: {
                          devise_person_info_params_data: person_info
                        }
      }

      it "new_address.html.hamlに偏移すること" do
        subject
        expect(response).to render_template :new_address
      end
    end
  end

  describe 'POST #create_address' do
    let(:address) { { user_id: user.id, address: attributes_for(:address,user_id: user.id), person_info: attributes_for(:person_info, user_id: user.id), user: attributes_for(:user)  } }
    let(:person_info_params) { {user_id: user.id, person_info: attributes_for(:person_info) }}

    before do
      request.env["devise.mapping"] = Devise.mappings[:user]
      user = attributes_for(:user)
      post :create, params: { user: user },
                        session: {
                          devise_regist_data: user
                        }
      person_info = attributes_for(:person_info)                
      post :create_person_info, params: { person_info: person_info},
                        session: {
                          devise_person_info_params_data: person_info
                        }
    end

    it "無効なデータの場合" do
      no_address = attributes_for(:address, family_name: nil)
      subject {
        post :create_address,
        params: {address: no_address}
      }
      subject
      expect(response).to render_template :new_address
    
    end
    
    context "有効なデータの場合"  do
      subject {
       # user = create(:user)
        #user = attributes_for(:user)
        #let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
        #attributes_for(:address)
        post :create_address, 
        params: address
        #{address: attributes_for(:address), person_info: attributes_for(:person_info), user: attributes_for(:user),address: {user_id: user.id}}
      }
  
      it "保存すること" do
        #binding.pry
        expect {
          subject
        }.to change( User, :count ).by(1).and change( PersonInfo, :count ).by(1).and change( Address, :count ).by(1)
        #expect{ subject }.to change(Address, :count).by(1)
      end

      it "ページ偏移すること" do
        
      end
    end
  end
end