require "rails_helper"
include Devise::TestHelpers

describe CommentsController, type: :controller do
  let(:review) {FactoryGirl.create(:review)}
  let (:user) {FactoryGirl.create(:user)}

  subject(:comment) {FactoryGirl.create :comment, review: review, user: user}
  before {sign_in user}

  describe "GET #index" do
    context "populates an array of comment" do
      before do
        get :index, review_id: review.id
      end
      it do
        expect(assigns(:comments)).to eq [subject]
      end
    end

    context "redirect the #show book" do
      before do
        get :index, review_id: review.id
         FactoryGirl.create :comment, review: review
      end
      it do
        expect(subject).to redirect_to(review.book)
      end
    end
  end

  describe "POST #create" do
    context "create comment success" do
      it do
        expect {post :create, comment: {content: "Test create comment",
          user_id: user.id, review_id: review.id} }.to change(Comment, :count).by(1)
        expect(flash[:success]).to eq I18n.t("application.flash.create_comment_success")
        expect(Comment.last).to redirect_to(review.book)
      end
    end

    context "create comment failed" do
      before {post :create, comment: {content: nil, user_id: nil, review_id: review}}
      it do
        expect(flash[:danger]).to eq I18n.t("application.flash.create_comment_failed")
      end
    end
  end

  describe "DELETE #destroy" do
    context "delete comment success" do
      before {@comment = FactoryGirl.create :comment, review: review, user: user}
      it do
        expect {delete :destroy, id: @comment.id}.to change(Comment, :count).by(-1)
        expect(flash[:success]).to eq I18n.t("application.flash.delete_comment_success")
      end
    end
  end
end
