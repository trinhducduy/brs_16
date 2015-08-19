require "rails_helper"
include Devise::TestHelpers

describe Admin::BooksController do
  let(:book) {double "book"}
  let(:book_id) {double "book_id"}
  let(:book_params) {{title: nil, author: nil, published_date: nil,
    number_of_page: nil, description: nil, image: nil, category_id: nil}}

  before do
    user = double("user")
    allow_message_expectations_on_nil
    allow(user).to receive(:admin?).and_return true
    allow(request.env["warden"]).to receive(:authenticate!).and_return user
    allow(controller).to receive(:current_user).and_return user
  end

  describe "#index" do
    before do
      allow(Book).to receive(:paginate).and_return [book]
      get :index
    end

    it do
      expect(assigns(:books)).to eq [book]
      expect(response).to render_template :index
    end
  end

  describe "#new" do
    before do
      allow(Book).to receive(:new).and_return book
      get :new
    end

    it do
      expect(assigns(:book)).to eq book
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    before do
      allow(Book).to receive(:find).and_return book
      get :edit, id: book_id
    end

    it do
      expect(assigns(:book)).to eq book
      expect(response).to render_template :edit
    end
  end

  describe "#destroy" do
    before do
      allow(Book).to receive(:find).and_return book
    end

    context "when the book is deleted successfully" do
      before do
        allow(book).to receive(:destroy).and_return true
        delete :destroy, id: book_id
      end

      it {expect(flash[:success]).to eq I18n.t("application.flash.delete_book_success")}
    end

    context "when failed to delete book" do
      before do
        allow(book).to receive(:destroy).and_return false
        delete :destroy, id: book_id
      end

      it {expect(flash[:danger]).to eq I18n.t("application.flash.delete_book_failed")}
    end
  end

  describe "#create" do
    before do
      allow(Book).to receive(:new).and_return book
    end

    context "when the book saves successfully" do
      before do
        allow(book).to receive(:save).and_return true
        post :create, book: book_params
      end

      it {expect(flash[:success]).to eq I18n.t("application.flash.create_book_success")}
    end

    context "when the book fails to save" do
      before do
        allow(book).to receive(:save).and_return false
        post :create, book: book_params
      end

      it {expect(response).to render_template :new}
    end
  end

  describe "#update" do
    before do
      allow(Book).to receive(:find).and_return book
    end

    context "when the book updates successfully" do
      before do
        allow(book).to receive(:update).and_return true
        put :update, id: book_id, book: book_params
      end

      it {expect(flash[:success]).to eq I18n.t("application.flash.update_book_success")}
    end

    context "when the book fails to update" do
      before do
        allow(book).to receive(:update).and_return false
        put :update, id: book_id, book: book_params
      end

      it {expect(subject).to render_template :edit}
    end
  end
end
