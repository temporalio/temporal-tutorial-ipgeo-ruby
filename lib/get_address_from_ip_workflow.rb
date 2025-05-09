# @@@SNIPSTART ruby-ipgeo-get-address-from-ip-workflow
require 'temporalio/workflow'
require 'temporalio/retry_policy' 

module IPGeolocate
  class GetAddressFromIPWorkflow < Temporalio::Workflow::Definition
    # Defines retry policy
    RETRY_POLICY = Temporalio::RetryPolicy.new(
      initial_interval: 2.0,           # amount of time that must elapse before the first retry occurs
      backoff_coefficient: 1.5,        # Coefficient used to calculate the next retry interval. The next retry interval is previous interval multiplied by the coefficient.
      max_interval: 30.0,              # maximum interval between retries
      # max_attempts: 5,                 # Uncomment this if you want to limit attempts
      # non_retryable_error_types:     # Defines non-retryable error types
    )
    def execute(name)
      ip = Temporalio::Workflow.execute_activity(
        GetIPActivity,
        schedule_to_close_timeout: 300,
        retry_policy: RETRY_POLICY
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
# @@@SNIPEND