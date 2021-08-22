class ShelfVolumesController < ApplicationController
    before_action :initialize_client_object
    def index
        begin
            @shelf_volumes = @client.shelf_volume(params[:user_id], params[:shelf])
        rescue RuntimeError
            @error = true
        end
    end

    private

    def initialize_client_object
        @client = GoogleBooks::V1::Client.new
    end
end

