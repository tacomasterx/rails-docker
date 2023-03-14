require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid email address" do
    user = FactoryBot.build(:user)
    expect(user).to include("@mail.com")
  end
end
