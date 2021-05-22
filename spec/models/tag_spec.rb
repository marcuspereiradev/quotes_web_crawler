require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to be_mongoid_document }

  context "Associations" do
    it { is_expected.to have_and_belong_to_many(:quotes).with_foreign_key(:quote_ids) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:tag_name) }

    it { is_expected.to have_field(:tag_name).of_type(String) }

    it 'should create an instance of Tag' do
      tag = Tag.new

      expect(tag).to be_instance_of(Tag)
    end

    it 'should not be blank attributes' do
      tag = Tag.new

      expect(tag.tag_name).to be_falsey
    end

    it "should be valid with valid attributes" do
      tag = Tag.new(tag_name: 'World')

      expect(tag.class).to eq(Tag)
      expect(tag.tag_name).to eq('World')
      expect(tag).to be_valid
    end
  end
end
