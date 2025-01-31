require "http"
require "./errors"
require "./request"
require "./text2image/text2image_request"
require "./text2image/text2image_response"

module SDAPI

    # Api Client for Automatic1111 Stable Diffusion
    class Client
        property url : String
        property port : Int32

        property username : String?
        property password : String?

        def initialize(@url : String, @port : Int32, @username : String? = nil, @password : String? = nil)
        end

        protected def headers
            headers = HTTP::Headers.new
            
            headers["Content-Type"] = "application/json"
            headers["Accept"] = "application/json"

            if @username && @password
                headers["Authorization"] = "Basic " + Base64.encode(@username.not_nil! + ":" + @password.not_nil!)
            end

            headers
        end

        def text2image(request : Text2ImageRequest) : Text2ImageResponse
            request(request).as(Text2ImageResponse)
        end

        def request(request : Request)
            method = request.method
            endpoint = request.endpoint

            http_response = request(method, endpoint, request.to_json)
            
            # Parse the response into the appropriate type
            response_type = request.response_type
            if response_type
                response_type.from_json(http_response)
            else
                http_response
            end
        end

        def request(method : String, endpoint : String, body : String = "")
            headers = self.headers

            full_url = "#{@url}:#{@port}#{endpoint}"
            response = HTTP::Client.exec(method: method, url: full_url, headers: headers, body: body)

            case response.status_code
            when 200, 201
                response.body
            when 422
                # Parse validation error
                raise ValidationError.from_json(response.body)
            else
                # Handle other HTTP errors
                message = response.body.presence || response.status_message
                raise HTTPError.new(response.status_code, message.not_nil!)
            end
        end
    end
end
