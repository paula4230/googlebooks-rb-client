class VolumesController < ApplicationController
    before_action :initialize_client_object
    def index
        begin
            @volume = @client.volume(params[:volume_Id])
        rescue RuntimeError
            @error = true
        end
    end

    private

    def initialize_client_object
        @client = GoogleBooks::V1::Client.new
    end
end

