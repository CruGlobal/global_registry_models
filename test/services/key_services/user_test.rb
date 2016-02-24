require 'test_helper'

class ServicesKeyServicesUserTest < ActiveSupport::TestCase
  def setup
    stub_request(:get, 'https://thekey.me/cas/api/test/user/attributes?email=bob@internet.com')
      .with(headers: { 'Accept' => 'application/json'})
      .to_return(status: 200, body: %({"relayGuid":"8F612500-0000-541D-FC38-2AF75974729F","ssoGuid":"8F612500-0000-541D-FC38-2AF75974729F","firstName":"Test","lastName":"User","theKeyGuid":"8F612500-0000-541D-FC38-2AF75974729F","email":"bob@internet.com"}), headers: {})
  
    stub_request(:get, 'https://thekey.me/cas/api/test/user/attributes?theKeyGuid=8F612500-0000-541D-FC38-2AF75974729F')
      .with(headers: { 'Accept' => 'application/json'})
      .to_return(status: 200, body: %({"relayGuid":"8F612500-0000-541D-FC38-2AF75974729F","ssoGuid":"8F612500-0000-541D-FC38-2AF75974729F","firstName":"Test","lastName":"User","theKeyGuid":"8F612500-0000-541D-FC38-2AF75974729F","email":"bob@internet.com"}), headers: {})
  end

  test '#cas_attributes' do
    user = KeyServices::User.new(email: 'bob@internet.com')
    assert_equal '8F612500-0000-541D-FC38-2AF75974729F', user.cas_attributes['ssoGuid']
    user = KeyServices::User.new(guid: '8F612500-0000-541D-FC38-2AF75974729F')
    assert_equal 'bob@internet.com', user.cas_attributes['email']
  end
end
