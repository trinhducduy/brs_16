require 'rails_helper'

describe Review do
  let(:user) {FactoryGirl.create :user}
  let(:book) {FactoryGirl.create :book}

  subject {FactoryGirl.build :review, user: user, book: book}

  context "user cannot review a book more than one time" do
    before {FactoryGirl.create :review, user: user, book: book}
    it {expect(subject.error_on(:user_id).size).to eq 1}
  end

  context "is invalid without content" do
    before {subject.content = nil}
    it {expect(subject.error_on(:content).size).to eq 1}
  end

  context "should return correct user" do
    before {subject.user = user}
    it {expect(subject.user).to eq user}
  end

  context "should return correct book" do
    before {subject.book = book}
    it {expect(subject.book).to eq book}
  end

  context "should caculate average rating on after save" do
    it {is_expected.to callback(:caculate_average_rating).after(:save)}
  end

  context "should create activity log before create" do
    it {is_expected.to callback(:create_review_log).before(:create)}
  end

  context "should inform new review before create" do
    it {is_expected.to callback(:inform_new_review).after(:create)}
  end

  it {expect have_many :comments}

end
