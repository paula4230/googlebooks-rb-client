class BookshelvesController < ApplicationController
    before_action :initialize_client_object
    def index
        begin
            @bookshelves = @client.bookshelf(params[:user_id])
        rescue RuntimeError
            @error = true
        end
    end

    private

    def initialize_client_object
        @client = GoogleBooks::V1::Client.new
    end
end

