module GoogleBooks
    module V1
        class Client
            API_ENDPOINT = 'https://www.googleapis.com'

            def initialize
                @api_key = 'AIzaSyDLjOcdf_yMfwgrYUwkhw7aPZsjExtS7tg'
            end

            #BookInfo

            def book_info(book_title)
                request(http_method: :get, endpoint: "books/v1/volumes?q=#{book_title}", key: @api_key)
            end

            #VolumeID
 
            #to access all volume ID details
            # def volume(volume_id)
            #     request(http_method: :get, endpoint: "books/v1/volumes/#{volume_id}", key: @api_key)
            # end

            def volume_title(volume_id)
                request(http_method: :get, endpoint: "books/v1/volumes/#{volume_id}", key: @api_key)['volumeInfo']['title']
            end

            def volume_subtitle(volume_id)
                request(http_method: :get, endpoint: "books/v1/volumes/#{volume_id}", key: @api_key)['volumeInfo']['subtitle']
            end

            def volume_authors(volume_id)
                request(http_method: :get, endpoint: "books/v1/volumes/#{volume_id}", key: @api_key)['volumeInfo']['authors']
            end

            def volume_publisher(volume_id)
                request(http_method: :get, endpoint: "books/v1/volumes/#{volume_id}", key: @api_key)['volumeInfo']['publisher']
            end

            def volume_description(volume_id)
                request(http_method: :get, endpoint: "books/v1/volumes/#{volume_id}", key: @api_key)['volumeInfo']['description']
            end


            def bookshelf(user_id)
                request(
                    http_method: :get,
                    endpoint: "books/v1/users/#{user_id}/bookshelves",
                    key: @api_key
                )
            end

            def shelf_volume(user_id, shelf)
                request(
                    http_method: :get,
                    # endpoint: "books/v1/users/112895977440900662718/bookshelves/#{shelf}/volumes",
                    endpoint: "books/v1/users/#{user_id}/bookshelves/#{shelf}/volumes",
                    key: @api_key
                )
            end

            def epub(book_title)
                request(
                    http_method: :get,
                    endpoint: "books/v1/volumes?q=#{book_title}&download=epub",
                    key: @api_key
                )
            end

            def request(http_method:, endpoint:, params: {}, key:)
                @response = connection.public_send(http_method, endpoint, params.merge(key: @api_key))
                parsed_response = JSON.parse(@response.body)

                return parsed_response if response_successful?

                raise RuntimeError, "Code #{@response.status}, response: #{@response.body}"
                 
            end

            def connection
                @connection ||= Faraday.new(API_ENDPOINT) do |f|
                f.request :url_encoded
                f.adapter Faraday.default_adapter
                end
            end

            def response_successful?
                @response.status == 200
            end
        end
    end
end