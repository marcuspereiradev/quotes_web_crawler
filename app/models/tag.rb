class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  field :tag_name, type: String

  def self.find_tag(params)
    self.find_or_create_by(tag_name: params)
  end
end
