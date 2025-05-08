# @@@SNIPSTART ruby-get-location-activity-test
require "test_helper"
require 'securerandom'
require 'temporalio/testing'
require "get_location_activity"

class GetLocationActivityTest < Minitest::Test
  def test_gets_ip
    env = Temporalio::Testing::ActivityEnvironment.new

    fake_location = {
      city: 'Sample City',
      regionName: 'Sample Region',
      country: 'Sample Country'
    }.to_json;

    Net::HTTP.stub(:get, ->(*) { fake_location }) do
      result = env.run(IPGeolocate::GetLocationActivity, "1.1.1.1")
      assert_equal "Sample City, Sample Region, Sample Country", result
    end
  end

end
# @@@SNIPEND