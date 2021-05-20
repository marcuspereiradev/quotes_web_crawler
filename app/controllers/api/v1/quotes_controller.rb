class Api::V1::QuotesController < Api::V1::ApiController
  def find_quotes
    if params[:search_tag].present?
      CrawlerService.execute(params[:search_tag])

      @quotes = Tag.find_by(tag_name: params[:search_tag]).quotes
      render json: @quotes
    end
  end
end
