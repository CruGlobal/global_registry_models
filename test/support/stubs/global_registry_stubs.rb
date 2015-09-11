module GlobalRegistryStubs
  def before_setup
    super

    # Search target areas
    stub_request(:get, /https:\/\/stage-api.global-registry.org\/entities\?entity_type=target_area&.*/).
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "entities": [
          {
            "target_area": {
              "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
              "name": "Institute of Technology",
              "country": "Philippines",
              "state": "SOCCSKSARGEN",
              "is_global_slm_team_target": true,
              "type": "College",
              "target_area_ministry_presence": "No Presence",
              "ministry:relationship": {
                "ministry": "33FB2B8A-58B8-11E5-98F1-6BAC9D6E46F5",
                "relationship_entity_id": "384295F2-58B8-11E5-98F1-6BAC9D6E46F5",
                "client_integration_id": "3C63F00E-58B8-11E5-8402-6BAC9D6E46F5"
              },
              "client_integration_id": "400BF486-58B8-11E5-9BB3-6BAC9D6E46F5"
            }
          },
          {
            "target_area": {
              "id": "641E71B8-58B9-11E5-910C-65A7C0F9A297",
              "type": "College",
              "name": "Helsingin kauppakorkeakoulu",
              "address1": "PO Box 1234  Runeberginkatu 12-34",
              "address2": "FIN-12345  Helsinki  Finland",
              "city": "Helsinki",
              "country": "FIN",
              "phone": "+123(4) 56-789",
              "email": "helsinki@fake.com",
              "is_no_fice_ok": "T",
              "client_integration_id": "688B7606-58B9-11E5-88C6-65A7C0F9A297"
            }
          }
        ],
        "meta": {
          "page": 1,
          "next_page": false,
          "from": 1,
          "to": 2
        }
      }))

    # Get a single target area
    stub_request(:get, "https://stage-api.global-registry.org/entities/219A7C20-58B8-11E5-B850-6BAC9D6E46F5").
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "entity": {
          "target_area": {
            "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
            "name": "Institute of Technology",
            "country": "Philippines",
            "state": "SOCCSKSARGEN",
            "is_global_slm_team_target": true,
            "type": "College",
            "target_area_ministry_presence": "No Presence",
            "ministry:relationship": {
              "ministry": "33FB2B8A-58B8-11E5-98F1-6BAC9D6E46F5",
              "relationship_entity_id": "384295F2-58B8-11E5-98F1-6BAC9D6E46F5",
              "client_integration_id": "3C63F00E-58B8-11E5-8402-6BAC9D6E46F5"
            },
            "client_integration_id": "400BF486-58B8-11E5-9BB3-6BAC9D6E46F5"
          }
        }
      }))

    # Blank search for "test" entity
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with filters for "test" entity
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&filters%5Battribute%5D%5Bnested%5D=test&filters%5Bname%5D=Mr&filters%5Bphone%5D=1-800-TEST").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with relationship filters
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&filters%5Bministry:relationship:role%5D=Director&filters%5Bwife:relationship%5D%5Bfirst_name%5D=wilma").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[],"meta":{"page":1,"next_page":false,"from":1,"to":1}}), :headers => {})

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

    # Get page 1 of "test" entities, the first page
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&page=1").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Get page 2 of "test" entities, the last page
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&page=2").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234"}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222"}}],"meta":{"page":2,"next_page":false,"from":3,"to":4}}), :headers => {})

    # Delete a "test" entity
    stub_request(:delete, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entity":{"test":{"id":"0000-0000-0000-0001"}}}), :headers => {})

    # Create a "test" entity
    stub_request(:post, "https://stage-api.global-registry.org/entities").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}", :headers => {})
    stub_request(:post, "https://stage-api.global-registry.org/entities").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"phone\":\"1800TEST\",\"name\":\"Mr. Test\"}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}", :headers => {})

    # Update a "test" entity
    stub_request(:put, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"phone\":\"1800TEST\",\"name\":\"Mr. Test\"}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}", :headers => {})
    stub_request(:put, "https://stage-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}",
           :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}", :headers => {})

  end
end

class ActiveSupport::TestCase
  include GlobalRegistryStubs
end
