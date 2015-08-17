require "rails_helper"
include Devise::TestHelpers

describe Admin::CategoriesController do
  let(:category) {mock_model Category}
  let(:input_name) {"New Category Name"}
  let(:input_desc) {"New Category Description"}

  before do
    sign_in FactoryGirl.create :admin
  end

  describe "#index" do
    let (:category1) {FactoryGirl.create :category}
    let (:category2) {FactoryGirl.create :category}

    before {get :index}

    it {expect(assigns(:categories)).to match_array([category2, category1])}
  end

  describe "#new" do
    before {get :new}

    it {expect(assigns(:category)).to be_a_new Category}
    it {expect(response).to render_template :new}
  end

  describe "#edit" do
    let(:category) {FactoryGirl.create :category}

    before {get :edit, id: category.id}

    it {expect(assigns(:category)).to eq category}
    it {expect(response).to render_template :edit}
  end

  describe "#destroy" do
    let(:category) {FactoryGirl.create :category}
    before {delete :destroy, id: category.id}

    it {expect(response).to redirect_to action: "index"}
  end

  describe "#create" do
    subject {post :create, category: {name: input_name, description: input_desc}}

    before do
      allow(Category).to receive(:new).and_return(category)
    end

    context "when the category saves successfully" do
      before do
        allow(category).to receive(:save).and_return(true)
      end

      it {expect(subject).to redirect_to action: "index"}
    end

    context "when the category fails to save" do
      before do
        allow(category).to receive(:save).and_return(false)
      end

      it {expect(subject).to render_template :new}
    end
  end

  describe "#update" do
    subject {put :update, id: category_id, category: {name: input_name,
      description: input_desc}}
    let (:category_id) {double "category_id"}

    before do
      allow(Category).to receive(:find).and_return(category)
    end

    context "when the category updates successfully" do
      before do
        allow(category).to receive(:update).and_return(true)
      end

      it {expect(subject).to redirect_to action: "index"}
    end

    context "when the category fails to update" do
      before do
        allow(category).to receive(:update).and_return(false)
      end

      it {expect(subject).to render_template :edit}
    end
  end
end
