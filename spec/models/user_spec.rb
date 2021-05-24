require 'rails_helper'

RSpec.describe User, type: :model do
  context "Validations" do
    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to have_field(:email).of_type(String) }
    it { is_expected.to have_field(:authentication_token).of_type(String) }

    it 'should create an instance of User' do
      user = User.new

      expect(user).to be_instance_of(User)
    end
  end

end
