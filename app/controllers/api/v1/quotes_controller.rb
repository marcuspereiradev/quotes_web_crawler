class Api::V1::QuotesController < Api::V1::ApiController
  def index
    if params[:search_tag].present?
      CrawlerService.execute(params[:search_tag])

      @quotes = Quote.with_tag(params[:search_tag])
    end
  end
end
