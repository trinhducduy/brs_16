require "rails_helper"

describe Admin::CategoriesController do
let(:category) {mock_model Category}
let(:input) {"New Category Name"}

  describe "POST create" do
    before do
      Category.stub(:new).and_return category
      post :create, category: {name: input}
    end

    it do
      expect(Category).to receive(:new).with(name: input).and_return category
    end

    it do
      expect(category).to receive :save
    end

    context "when the category saves successfully" do
      before do
       category.stub(:save).and_return true
      end

      it {expect(flash[:notice]).to eq("The category was saved successfully.")}
      it {expect(response).to redirect_to action: "index"}
    end

    context "when the category fails to save" do
      before do
        category.stub(:save).and_return false
      end

      it {expect(assigns[:category]).to be category}
      it {expect(response).to render_template "new"}
    end
  end

  describe "GET new"
    it "response successfully with a HTTP 200 status code"
      get :index
        expect(response).to be_success
        expect(response).to have_http_status(200)
      end
    end
  end
end
