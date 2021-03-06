class QuoteSerializer < ActiveModel::Serializer
  attributes :quote, :author, :author_about

  has_many :tags

  def tags
    object.tags.map(&:tag_name)
  end
end
