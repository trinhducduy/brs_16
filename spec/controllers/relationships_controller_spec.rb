require 'rails_helper'
include Devise::TestHelpers

describe RelationshipsController, type: :controller do
  let(:user) {FactoryGirl.create(:user)}
  let(:other_user) {FactoryGirl.create(:user)}

  before {sign_in user}

  describe "POST #create" do
    context "create a relationship success" do
      it do
        expect {post :create, user_id: other_user.id}.to change(Relationship,:count).by(1)
      end
    end

    context "create a relationship failed" do
      before do
        user.active_relationships.create followed_id: other_user.id
        post :create, user_id: other_user.id
      end
      it do
        expect(flash[:danger]).to eq I18n.t("application.flash.something_wrong")
      end
    end
  end

  describe "DELETE #destroy" do
    context "destroy a relationship" do
      before {user.active_relationships.create followed_id: other_user.id}
      it do
        expect {
          delete :destroy, id: Relationship.find_by(follower_id: user.id, followed_id: other_user.id).id
        }.to change(Relationship, :count).by(-1)
      end
    end
  end
end
