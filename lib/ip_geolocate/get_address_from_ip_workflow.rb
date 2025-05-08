require 'temporalio/workflow'

module IPGeolocate
  class GetAddressFromIPWorkflow < Temporalio::Workflow::Definition
    def execute(name)
      ip = Temporalio::Workflow.execute_activity(
        GetIPActivity,
        schedule_to_close_timeout: 300
      )

      location = Temporalio::Workflow.execute_activity(
        GetLocationActivity,
        ip,
        schedule_to_close_timeout: 300
      )

      "Hello, #{name}. Your IP is #{ip} and you are located in #{location}."

    end
  end
end
