require 'rubygems'
require "rest-client"
require "crack"

def getLocation(address)
    api_url = "http://maps.googleapis.com/maps/api/geocode/xml?address="
    api_url += address
    res = RestClient.get(URI.encode(api_url))
    parsed_result = Crack::XML.parse(res)
    long = parsed_result["GeocodeResponse"]["result"]["geometry"]["location"]["lng"]
    lat = parsed_result["GeocodeResponse"]["result"]["geometry"]["location"]["lat"]
    return "#{lat}, #{long}"
end

puts getLocation("1 times square, NYC")