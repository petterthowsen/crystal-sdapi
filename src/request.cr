module SDAPI
    abstract class Request
        include JSON::Serializable
        
        abstract def method : String
        abstract def endpoint : String
        
        # Returns the type that the response should be parsed into
        def response_type
            {{ @type.name.stringify.gsub(/Request$/, "Response").id }}
        end
    end
end