# @@@SNIPSTART ruby-ip-activity-test
require 'test_helper'
require 'securerandom'
require 'temporalio/testing'
require 'ip_geolocate/get_ip_activity'

class GetIPActivityTest < Minitest::Test
  def test_gets_ip
    env = Temporalio::Testing::ActivityEnvironment.new

    Net::HTTP.stub(:get, ->(*) { "1.1.1.1" }) do
      result = env.run(IPGeolocate::GetIPActivity)
      assert_equal "1.1.1.1", result
    end
  end

end
# @@@SNIPEND