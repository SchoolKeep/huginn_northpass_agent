require 'rails_helper'
require 'huginn_agent/spec_helper'

describe Agents::NorthpassS3Agent do
  before(:each) do
    @valid_params = {
      mode: 'write',
      access_key_id: '32343242',
      access_key_secret: '1231312',
      watch: 'false',
      bucket: 'testbucket',
      region: 'us-east-1',
      filename: 'file.csv',
      data: '{{ data }}'
    }
    @checker = Agents::NorthpassS3Agent.new(
      name: 'somename',
      schedule: 'never',
      options: @valid_params
    )
    @checker.user = users(:jane)
    @checker.save!
  end

  context '#receive' do
    it 'writes the data at data into a file' do
      client_mock = mock()
      mock(client_mock).put_object(
        bucket: @checker.options['bucket'],
        key: @checker.options['filename'],
        body: 'hello world!',
        content_type: 'text/csv',
        content_disposition: 'attachment'
      )
      mock(@checker).client { client_mock }
      event = Event.new(payload: { data: 'hello world!' })
      @checker.receive([event])
    end
  end
end
