require "rails_helper"

describe User do
  it { is_expected.to allow_value("+48 999 888 777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.to allow_value("48 999-888-777").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("aaa +48 aaa bbb ccc").for(:phone_number) }
  it { is_expected.not_to allow_value("+48 999 888 777\naseasd").for(:phone_number) }


  describe ".most_comments" do
    context "returns valid relation containing" do
      it "exactly 10 users" do
        create_list(:user, 20, :with_comments)
        expect(User.most_comments.to_a.count).to eq(10)
      end
      it "users with comments not older than 7 days" do
        user_new_comments = FactoryBot.create(:user, :with_comments)
        user_old_comments = FactoryBot.create(:user, :with_old_comments)

        expect(User.most_comments).to include(user_new_comments)
        expect(User.most_comments).to_not include(user_old_comments)
      end
      it "users sorted descending by comments count" do
        user1 = FactoryBot.create(:user, :with_one_comment)
        user2 = FactoryBot.create(:user, :with_two_comments)
        user3 = FactoryBot.create(:user, :with_three_comments)

        expect(User.most_comments).to eq [user3, user2, user1]
        expect(User.most_comments).to_not eq [user1, user3, user2]
      end
    end
    context "returns empty relation" do
      it "when users got no comments" do
        create_list(:user, 20)
        expect(User.most_comments).to be_empty
      end
      it "when users comments are older than 7 days" do
        create_list(:user, 20, :with_old_comments)
        expect(User.most_comments).to be_empty
      end
    end
  end
end
