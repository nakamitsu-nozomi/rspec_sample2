require 'rails_helper'

RSpec.describe "Users", type: :request do
  #一覧ページのテストコード
  describe "GET#index" do
    subject{get(users_path)}
    context "ユーザーが存在する時" do
      before {create_list(:user,3)}
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
      it  "nameが表示される" do
        subject
        expect(response.body).to include(*User.pluck(:name))
      end
    end
  end

  #showページのテストコード
  describe "GET#show" do
    subject{get(user_path(user_id))}
    context "ユーザーが存在する時" do
      let(:user){create(:user)}
      let(:user_id){user.id}
      it "リクエストが成功する" do
        subject
        expect(response).to have_http_status(:ok)
      end
      it  "nameが表示される" do
        subject
        expect(response.body).to include user.name
      end
      it  "ageが表示される" do
        subject
        expect(response.body).to include user.age.to_s
      end 

      it  "emailが表示される" do
        subject
        expect(response.body).to include user.email
      end
    end
    context ":idに対応するユーザーが存在しない時" do
      let(:user_id){1}
      it "エラーが発生する" do
        expect{subject}.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  #新規投稿ページのテストコード
    describe "GET#new" do
      subject{get(new_user_path)}
      it "リクエストが成功する" do
         subject
        expect(response).to have_http_status(:ok)
      end
    end

end
