class BooksController < ApplicationController
    before_action :initialize_client_object
    def index
        begin
            @books = @client.book_info(params[:book_title])
            @not_in_list = @books['totalItems'] == 0
            @items = @books['items']
        rescue RuntimeError
            @error = true
        end
    end

    

    private

    def initialize_client_object
        @client = GoogleBooks::V1::Client.new
    end
end 