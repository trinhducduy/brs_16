require 'rails_helper'

describe Comment, type: :model do

  let(:user) {FactoryGirl.create :user}
  subject(:comment) {FactoryGirl.create :comment, user: user}

  context "returns comments latest" do
    let(:other_comment) {FactoryGirl.create :comment,
      created_at: Time.now + 1, updated_at: Time.now + 1 }
    it {expect(Comment.latest).to eq [other_comment, subject]}
  end

  context "is invalid without content" do
    before {subject.content = nil}
    it {expect(comment.error_on(:content).size).to eq 1}
  end

  context "should create activity comment log on before create" do
    it {is_expected.to callback(:create_comment_log).before(:create)}
  end

  context "should inform new comment log on after create" do
    it {is_expected.to callback(:inform_new_comment).after(:create)}
  end

  context "should correct user" do
    it {expect(subject.user).to eq user}
  end

  context "should correct review" do
    before do
      @review = FactoryGirl.create :review
      subject.review = @review
    end
    it {expect(subject.review).to eq @review}
  end
end
