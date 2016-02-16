require 'test_helper'
require 'sidekiq/testing'

class ExportCsvJobTest < ActiveJob::TestCase
  test '.perform_later' do
    Sidekiq::Testing.fake! do
      assert_enqueued_with job: ExportCsvJob do
        ExportCsvJob.perform_later entity_class_name: 'test', filters: {}, email: 'tester@ballistiq.com'
      end
    end
  end

  test 'delivery sent when results are received' do
    ExportCsvJob.new.perform entity_class_name: 'test', filters: {}, email: 'tester@ballistiq.com'
    delivery = ActionMailer::Base.deliveries.last
    assert_equal ['tester@ballistiq.com'], delivery.to
    assert_equal "client_integration_id,id,name,phone\n1234,0000-0000-0000-0001,Mr. Test,+1234567890\n2222,0000-0000-0000-0002,Count Testalot,1800TEST\n1234,0000-0000-0000-0001,Mr. Test,+1234567890\n2222,0000-0000-0000-0002,Count Testalot,1800TEST\n",
                 delivery.attachments.first.body.raw_source
  end

  test 'delivery sent when timeout' do
    silence_stream(STDOUT) do
      ExportCsvJob.new.perform entity_class_name: 'test_timeout', filters: {}, email: 'tester@ballistiq.com'
    end
    delivery = ActionMailer::Base.deliveries.last
    assert_equal ['tester@ballistiq.com'], delivery.to
    assert_equal 'Your requst has too many results', delivery.subject
  end
end
