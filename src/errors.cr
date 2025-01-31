require "json"

module SDAPI
  class Error < Exception
  end

  class HTTPError < Error
    property status_code : Int32

    def initialize(@status_code : Int32, message : String)
      super("HTTP #{status_code}: #{message}")
    end
  end

  class ValidationErrorDetail
    include JSON::Serializable

    property loc : Array(JSON::Any)
    property msg : String
    property type : String
  end

  class ValidationErrorResponse
    include JSON::Serializable
    
    property detail : Array(ValidationErrorDetail)
  end

  class ValidationError < Error
    getter detail : Array(ValidationErrorDetail)

    def self.from_json(json : String) : ValidationError
      response = ValidationErrorResponse.from_json(json)
      new(response.detail)
    end

    def initialize(@detail : Array(ValidationErrorDetail))
      message = detail.map { |d| "#{d.msg} at #{d.loc.join(".")}" }.join(", ")
      super(message)
    end
  end
end
