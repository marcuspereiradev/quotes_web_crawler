class Api::V1::QuotesController < Api::V1::ApiController
  before_action :set_quote, only: [:update, :destroy]

  def index
    @quotes = Quote.all
    render json: @quotes
  end

  def update
    unless @quote.nil?
      if @quote.update(quote_params)
        render json: @quote
      else
        head :unprocessable_entity
      end
    else
      head :not_found
    end
  end

  def destroy
    unless @quote.nil?
      @quote.destroy!
      head :no_content
    else
      head :not_found
    end
  end

  def find_quotes
    CrawlerService.execute(params[:search_tag])

    tag = Tag.with_tag_name(params[:search_tag]).first

    unless tag.nil?
      @quotes = tag.quotes
      render json: @quotes
    else
      head :not_found
    end
  end

  private

  def quote_params
    params.require(:quote).permit(:quote, :author, :author_about)
  end

  def set_quote
    @quote = Quote.where(_id: params[:id]).first
  end
end
