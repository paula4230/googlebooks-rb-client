class DownloadsController < ApplicationController
    before_action :initialize_client_object
    def index
        begin
            @downloads = @client.epub(params[:book_title])
            @not_in_list = @downloads['totalItems'] == 0
            @items = @downloads['items']
        rescue RuntimeError
            @error = true
        end
    end

    

    private

    def initialize_client_object
        @client = GoogleBooks::V1::Client.new
    end
end 