#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + '/../lib')

require 'ip_geolocate/get_address_from_ip_workflow'
require 'ip_geolocate/task_queue_name'
require 'temporalio/client'

name = ARGV[0]
unless name
  puts "Please provide your name when running the program."
  exit 1
end

# Create a client
begin
  client = Temporalio::Client.connect('localhost:7233', 'default')
rescue StandardError => e
  puts "Unable to connect to Temporal. Is the server running?"
  exit 1
end

# Run workflow
result = client.execute_workflow(
  IPGeolocate::GetAddressFromIPWorkflow,
  name, # This is the input to the workflow
  id: 'my-workflow-id',
  task_queue: IPGeolocate::TASK_QUEUE_NAME,
)

puts result
