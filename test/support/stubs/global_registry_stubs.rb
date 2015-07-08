module GlobalRegistryStubs
  def before_setup
    super

    # Blank search for "test" entity
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with filters for "test" entity
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&filters%5Battribute%5D%5Bnested%5D=test&filters%5Bname%5D=Mr&filters%5Bperson:relationship:role:exists%5D=&filters%5Bphone%5D=1-800-TEST").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with order for "test" entity
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&order=name%20asc,phone%20desc").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with pagination
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&page=45&per_page=76").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":45,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Get a "test" entity
    stub_request(:get, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entity":{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}}}), :headers => {})

    # Get page 1 of all "test" entities
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&page=1").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Delete a "test" entity
    stub_request(:delete, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entity":{"test":{"id":"0000-0000-0000-0001"}}}), :headers => {})

    # Create a "test" entity
    stub_request(:post, "https://stage-api.global-registry.org/entities").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":1}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'84', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":1}}}", :headers => {})

    # Update a "test" entity
    stub_request(:put, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":1}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'84', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":1}}}", :headers => {})

  end
end

class ActiveSupport::TestCase
  include GlobalRegistryStubs
end
