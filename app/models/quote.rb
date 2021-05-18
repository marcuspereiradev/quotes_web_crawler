class Quote
  include Mongoid::Document
  include Mongoid::Timestamps
  field :quote, type: String
  field :author, type: String
  field :author_about, type: String
  field :tags, type: Array

  scope :with_tag, ->(search_tag) { where(:tags.in => ["#{search_tag}"]) }
end
