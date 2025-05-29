# @@@SNIPSTART ruby-get-address-from-ip-workflow-test
require 'test_helper'
require 'securerandom'
require 'temporalio/testing'
require 'temporalio/worker'
require 'ip_geolocate'

class GetAddressFromIPWorkflowTest < Minitest::Test
  class MockGetIPActivity < Temporalio::Activity::Definition
    activity_name :GetIPActivity

    def execute
      "1.1.1.1"
    end
  end
  
  class MockGetLocationActivity < Temporalio::Activity::Definition
    activity_name :GetLocationActivity

    def execute(ip)
      "Planet Earth"
    end
  end

  def test_gets_location_from_ip_with_mocked_activities
    Temporalio::Testing::WorkflowEnvironment.start_local do |env|
      worker = Temporalio::Worker.new(
        client: env.client,
        task_queue: "test",
        workflows: [IPGeolocate::GetAddressFromIPWorkflow],
        activities: [MockGetIPActivity, MockGetLocationActivity],
        workflow_executor: Temporalio::Worker::WorkflowExecutor::ThreadPool.default
      )
      worker.run do
        result = env.client.execute_workflow(
          IPGeolocate::GetAddressFromIPWorkflow,
          "Testing",
          id: "test-#{SecureRandom.uuid}",
          task_queue: worker.task_queue
        )
        assert_equal 'Hello, Testing. Your IP is 1.1.1.1 and you are located in Planet Earth.', result
      end
    end
  end
end
# @@@SNIPEND