require "json"

module SDAPI
    struct Text2ImageResponse
        include JSON::Serializable

        # array of base64 encoded images
        getter images : Array(String)

        # info string containing generation parameters
        getter info : String

        # parameters used for generation
        getter parameters : Hash(String, JSON::Any)?
    end
end