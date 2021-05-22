require 'rails_helper'

RSpec.describe Quote, type: :model do
  it { is_expected.to be_mongoid_document }

  context "Associations" do
    it { is_expected.to have_and_belong_to_many(:tags).with_foreign_key(:tag_ids) }
  end

  context "Validations" do
    it { is_expected.to validate_presence_of(:quote) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:author_about) }

    it { is_expected.to have_field(:quote).of_type(String) }
    it { is_expected.to have_field(:author).of_type(String) }
    it { is_expected.to have_field(:author_about).of_type(String) }

    it 'should create an instance of Quote' do
      quote = Quote.new

      expect(quote).to be_instance_of(Quote)
    end

    it 'should not be blank attributes' do
      quote = Quote.new

      expect(quote.quote).to be_falsey
      expect(quote.author).to be_falsey
      expect(quote.author_about).to be_falsey
    end

    it "should be valid with valid attributes" do
      quote = Quote.new(quote: "The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.",
                        author: "Albert Einstein",
                        author_about: "http://quotes.toscrape.com/author/Albert-Einstein")

      expect(quote.class).to eq(Quote)
      expect(quote.quote).to eq("The world as we have created it is a process of our thinking. It cannot be changed without changing our thinking.")
      expect(quote.author).to eq("Albert Einstein")
      expect(quote.author_about).to eq("http://quotes.toscrape.com/author/Albert-Einstein")
      expect(quote).to be_valid
    end
  end
end
