require "rails_helper"

describe Category do
  subject(:category) {FactoryGirl.create :category}
  let(:another_category) {FactoryGirl.create :category,
    created_at: Time.now + 1, updated_at: Time.now + 1 }

  describe "association" do
    it {expect have_many :books}
  end

  context "is invalid without a name" do
    before {category.name = nil}
    it {expect(category.error_on(:name).size).to eq 2}
  end

  context "is invalid without a description" do
    before {category.description = nil}
    it {expect(category.error_on(:description).size).to eq 2}
  end

  context "is invalid with a short name" do
    before {category.name = "Name"}
    it {expect(category.error_on(:name).size).to eq 1}
  end

  context "is invalid with a short description" do
    before {category.description = "Description"}
    it {expect(category.error_on(:description).size).to eq 1}
  end

  it "should return categories in correct order" do
    expect(Category.latest.limit(2)).to eq [another_category, category]
  end
end
