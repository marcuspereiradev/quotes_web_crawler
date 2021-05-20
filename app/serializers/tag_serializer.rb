class TagSerializer < ActiveModel::Serializer
  attributes :tag_name

  has_many :quotes
end
