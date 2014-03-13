require 'net/http'
require 'uri'

class Geolocate

  def self.find(ip_address = nil)
    uri = URI("http://ipinfo.io/#{ip_address + '/' if ip_address }json")
    string_response = Net::HTTP.get(uri)
    response = JSON.parse(string_response)
    response.merge!("latitude" => response["loc"].split(',').first, "longitude" => response["loc"].split(',').last)

  end

end











# require 'net/http'
# require 'uri'

# class IpInfo

#   def get_ip_info(ip_address = nil)
#     uri = URI("http://ipinfo.io/#{ ip_address + '/' if ip_address.present? }json")
#     data = Net::HTTP.start(uri.host, uri.port) do |http|
#       request = Net::HTTP::Get.new uri
#       response = http.request request
#     end
#     ipinfo = JSON.parse(data.body)
#     lat, long = ipinfo['loc'].split(',')
#     ipinfo.merge('latitude' => lat, 'longitude' => long)
#   end

# end
