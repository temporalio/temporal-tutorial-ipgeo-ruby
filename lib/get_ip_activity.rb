# @@@SNIPSTART ruby-ipgeo-get-public-ip
require 'temporalio/activity'
require 'net/http'
require 'uri'
require 'json'

module IPGeolocate
  class GetIPActivity < Temporalio::Activity::Definition
    def execute
      url = URI('https://icanhazip.com')
      response = Net::HTTP.get(url)
      response.strip
    end
  end
end
# @@@SNIPEND