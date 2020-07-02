# frozen_string_literal: true

module Agents
  class NorthpassS3Agent < S3Agent
    description do
      <<-MD
        The S3Agent can watch a bucket for changes or emit an event for every file in that bucket. When receiving events, it writes the data into a file on S3.

        #{'## Include `aws-sdk-core` in your Gemfile to use this Agent!' if dependencies_missing?}

        `mode` must be present and either `read` or `write`, in `read` mode the agent checks the S3 bucket for changed files, with `write` it writes received events to a file in the bucket.

        ### Universal options

        To use credentials for the `access_key` and `access_key_secret` use the liquid `credential` tag like so `{% credential name-of-credential %}`

        Select the `region` in which the bucket was created.

        ### Reading

        When `watch` is set to `true` the S3Agent will watch the specified `bucket` for changes. An event will be emitted for every detected change.

        When `watch` is set to `false` the agent will emit an event for every file in the bucket on each sheduled run.

        #{emitting_file_handling_agent_description}

        ### Writing

        Specify the filename to use in `filename`, Liquid interpolation is possible to change the name per event.

        Use [Liquid](https://github.com/huginn/huginn/wiki/Formatting-Events-using-Liquid) templating in `data` to specify which part of the received event should be written.
      MD
    end

    def receive(incoming_events)
      return if interpolated['mode'] != 'write'

      incoming_events.each do |event|
        safely do
          mo = interpolated(event)
          client.put_object(
            bucket: mo['bucket'],
            key: mo['filename'],
            body: mo['data'],
            content_type: 'text/csv',
            content_disposition: 'attachment'
          )
        end
      end
    end
  end
end
