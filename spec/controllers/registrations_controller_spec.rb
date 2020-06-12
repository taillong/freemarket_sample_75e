require 'rails_helper'

describe Users::RegistrationsController  do
  let(:user) {attributes_for(:user)}
  let(:person_info) {attributes_for(:person_info)}
  let(:address) {attributes_for(:address)}

  before do
    request.env["devise.mapping"] = Devise.mappings[:user]
  end
    
  describe 'GET #new' do
    it "new.html.hamlに遷移すること" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context "無効なデータの場合" do 
      let(:no_user) {attributes_for(:user, email: nil)}
      subject {
        post :create, params: {user: no_user}
      }
      it "バリデーションを通らなかった場合new.html.hamlに偏移する" do
        subject
        expect(response).to render_template :new
      end  
    end

    context "有効なデータの場合"  do
      subject {
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
      session["devise_regist_data"] = {user: user}
    end

    context "無効なデータの場合" do
      let(:no_person_info)  {attributes_for(:person_info, family_name: nil)}
      subject {
        post :create_person_info, params: { person_info: no_person_info}
      }

      it "new_person_infoに偏移すること" do
        subject
        expect(response).to render_template :new_person_info
      end
    end
    
    context "有効なデータの場合"  do
      subject {
        post :create_person_info, params: { person_info: person_info},
                        session: {
                          user: user,
                          person_info: person_info
                        }
      }

      it "new_address.html.hamlに偏移すること" do
        subject
        expect(response).to render_template :new_address
      end
    end
  end

  describe 'POST #create_address' do
    before do
      session["devise_regist_data"] = {user: user} 
      session["devise_person_info_data"] = {person_info: person_info}
    end

    context "無効なデータの場合" do
      let(:no_address)  {attributes_for(:address, family_name: nil)}
      subject {
        post :create_address, params: { address: no_address}
      }

      it "new_adress.html.hamlに偏移" do
        subject
        expect(response).to render_template :new_address
      end
    end
    
    context "有効なデータの場合"  do
      subject {
        post :create_address, 
        params: { address: address},
                      session: {
                        user: user,
                        person_info: person_info,
                        address: address
                      }
      }
  
      it "new_card.html.hamlに偏移すること" do
          subject
          expect(response).to render_template :new_card
      end
    end
  end

  describe 'POST #create_card' do
    let(:card) {attributes_for(:card)}
    before do
      session["devise_regist_data"] = {user: user} 
      session["devise_person_info_data"] = {person_info: person_info}
      session["devise_address_data"] = {address: address}
    end

    context "payjpを用いない場合" do
      let(:params) { {user: user, person_info: person_info, address: address} }
      subject {
        post :create_card, params: params
      }
      
      it "new_card.html.hamlに偏移" do
        subject
        expect(response).to render_template :new_card
      end
    end

    context "payjpを用いている場合"  do
      let(:params) { {user: user, person_info: person_info, address: address, payjpToken: "xxxxxxxxxxxxxxxx"} }

      context "データが無効な場合" do
        before do
          customer = allow(Payjp::Customer).to receive(:create).and_return(id: nil)
        end
          subject {
            card = attributes_for(:card)
            post :create_card, params: params,
                                  session: {
                                    user: user,
                                    person_info: person_info,
                                    address: address
                                  }
          
            session["devise_regist_data"] = {user: user}.clear
            session["devise_person_info_data"] = {person_info: person_info}.clear
            session["devise_address_data"] = {address: address}.clear
          }

          it "new_card.html.hamlに偏移" do
            subject
            expect(response).to render_template :new_card
          end
      end

      context "データが有効な場合" do
        before do
          customer = allow(Payjp::Customer).to receive(:create).and_return(PayjpMock.prepare_customer_information)
        end
          subject {
            card = attributes_for(:card)
            post :create_card, params: params,
                                  session: {
                                    user: user,
                                    person_info: person_info,
                                    address: address
                                  }
          
            session["devise_regist_data"] = {user: user}.clear
            session["devise_person_info_data"] = {person_info: person_info}.clear
            session["devise_address_data"] = {address: address}.clear
          }
    
        it "データの保存をすること" do
          expect {
            subject
          }.to change( User, :count ).by(1).and change( PersonInfo, :count ).by(1).and change( Address, :count ).by(1).and change( Card, :count ).by(1)
        end
  
        it "ホームページ偏移すること" do
          subject
          expect(response).to redirect_to(root_path)
        end
      end
    end
  end

  describe 'POST #create_skip' do
    before do
      session["devise_regist_data"] = {user: user} 
      session["devise_person_info_data"] = {person_info: person_info}
      session["devise_address_data"] = {address: address}
    end

    context "有効なデータの場合"  do
      let(:params) { { user: user, person_info: person_info, address: address} }
      subject {
        post :create_skip, params: params,
                              session: {
                                user: user,
                                person_info: person_info,
                                address: address
                              } 
        session["devise_regist_data"] = {user: user}.clear
        session["devise_person_info_data"] = {person_info: person_info}.clear
        session["devise_address_data"] = {address: address}.clear
      }
  
      it "データの保存すること" do
        expect {
          subject
        }.to change( User, :count ).by(1).and change( PersonInfo, :count ).by(1).and change( Address, :count ).by(1)
      end

      it "ホームページ偏移すること" do
        subject
        expect(response).to redirect_to(root_path)
      end
    end
  end
end