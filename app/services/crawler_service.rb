require 'net/http'
require 'nokogiri'

class CrawlerService
  def self.execute(params_search_tag)
    fetch_quote(params_search_tag)
  end

  private

  def self.fetch_quote(params_search_tag)
    uri = URI('http://quotes.toscrape.com')
    doc = Nokogiri::HTML(Net::HTTP.get(uri))

    doc.css('.quote').each do |quote|
      quote_tags = quote.css('.tags').css('.tag').map { |tag| tag.text }

      if quote_tags.include?(params_search_tag)
        hash = Hash.new
        hash["quote"] = quote.css('.text').text
        hash["author"] = quote.css('.author').text
        hash["author_about"] = "#{uri}#{quote.css('span')[1].css('a')[0]['href']}"
        hash["tags"] = quote.css('.tags').css('.tag').map { |tag| Tag.find_tag(tag.text); tag.text }

        quote_content = Quote.find_or_create_by(
          quote: hash["quote"],
          author: hash["author"],
          author_about: hash["author_about"],
          tags: hash["tags"]
        )
      end
    end
  end
end
