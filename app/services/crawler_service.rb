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

    doc.css('.quote').each do |element|
      quote_tags = element.css('.tags').css('.tag').map { |tag| tag.text }

      if quote_tags.include?(params_search_tag)
        hash = Hash.new
        hash['quote'] = element.css('.text').text.gsub(/\A\W|\W\z/, '')
        hash['author'] = element.css('.author').text
        hash['author_about'] = "#{uri}#{element.css('span')[1].css('a')[0]['href']}"
        hash['tags'] = quote_tags.map { |tag| Tag.find_or_create_by(tag_name: tag) }

        quote = Quote.find_or_initialize_by(quote: hash['quote'],
                                            author: hash['author'],
                                            author_about: hash['author_about'])
        quote.tags = hash['tags']
        quote.save
      end
    end
  end
end
