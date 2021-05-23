class Api::V1::QuotesController < Api::V1::ApiController
  def find_quotes
    CrawlerService.execute(params[:search_tag])

    tag = Tag.with_tag_name(params[:search_tag]).first

    unless tag.nil?
      @quotes = tag.quotes
      render json: @quotes
    else
      render json: { error: 'Not found' }, status: 404
    end
  end
end
