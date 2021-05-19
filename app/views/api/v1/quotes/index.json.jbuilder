json.quotes @quotes do |quote|
  json.quote quote.quote
  json.author quote.author
  json.author_about quote.author_about
  json.tags quote.tags.map { |tag| tag.tag_name }
end
