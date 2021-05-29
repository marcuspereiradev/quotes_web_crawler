# frozen_string_literal: true

module Api
  module V1
    # Quotes controller defines the creation of quotes
    class QuotesController < Api::V1::ApiController
      before_action :set_quote, only: %i[update destroy]

      def index
        @quotes = Quote.all
        render json: @quotes
      end

      def update
        return head :not_found if @quote.nil?

        if @quote.update(quote_params)
          render json: @quote
        else
          head :unprocessable_entity
        end
      end

      def destroy
        return head :not_found if @quote.nil?

        @quote.destroy!
        head :no_content
      end

      def find_quotes
        CrawlerService.execute(params[:search_tag])

        tag = Tag.with_tag_name(params[:search_tag]).first

        return head :not_found if tag.nil?

        @quotes = tag.quotes
        render json: @quotes
      end

      private

      def quote_params
        params.require(:quote).permit(:quote, :author, :author_about)
      end

      def set_quote
        @quote = Quote.where(_id: params[:id]).first
      end
    end
  end
end
