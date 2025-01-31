require "./client"

module SDAPI
	VERSION = "0.1.0"
	
	alias JSONValue = String | Int32 | Int64 | Float32 | Float64 | Bool | Nil | Array(JSONValue) | Hash(String, JSONValue)
end
