class Api::V1::QuotesController < Api::V1::ApiController
  before_action :set_quote, only: %i[update destroy]

  def index
    @quotes = Quote.all
    render json: @quotes
  end

  def update
    if @quote.nil?
      head :not_found
    elsif @quote.update(quote_params)
      render json: @quote
    else
      head :unprocessable_entity
    end
  end

  def destroy
    if @quote.nil?
      head :not_found
    else
      @quote.destroy!
      head :no_content
    end
  end

  def find_quotes
    CrawlerService.execute(params[:search_tag])

    tag = Tag.with_tag_name(params[:search_tag]).first

    if tag.nil?
      head :not_found
    else
      @quotes = tag.quotes
      render json: @quotes
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
