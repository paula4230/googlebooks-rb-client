class VolumesController < ApplicationController
    before_action :initialize_client_object
    def index
        begin
            @volume_title = @client.volume_title(params[:volume_Id])
            @volume_subtitle = @client.volume_subtitle(params[:volume_Id])
            @volume_authors = @client.volume_authors(params[:volume_Id])
            @volume_publisher = @client.volume_publisher(params[:volume_Id])
            @volume_description = @client.volume_description(params[:volume_Id])
        rescue RuntimeError
            @error = true
        end
    end

    private

    def initialize_client_object
        @client = GoogleBooks::V1::Client.new
    end
end

