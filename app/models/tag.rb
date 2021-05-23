class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :tag_name, type: String

  has_and_belongs_to_many :quotes

  validates :tag_name, presence: true

  scope :with_tag_name, ->(tag) { where(tag_name: tag) }
end
