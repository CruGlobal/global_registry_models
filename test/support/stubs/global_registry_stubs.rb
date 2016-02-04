module GlobalRegistryStubs
  def before_setup
    super

    # Search test entity
    stub_request(:get, /https:\/\/stage-api.global-registry.org\/entities\?entity_type=test&.*/).
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "entities": [
          {
            "test": {
              "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
              "name": "Institute of Technology",
              "phone": "+1-234-567-8901",
              "ministry:relationship": {
                "ministry": "33FB2B8A-58B8-11E5-98F1-6BAC9D6E46F5",
                "relationship_entity_id": "384295F2-58B8-11E5-98F1-6BAC9D6E46F5",
                "client_integration_id": "3C63F00E-58B8-11E5-8402-6BAC9D6E46F5"
              },
              "client_integration_id": "400BF486-58B8-11E5-9BB3-6BAC9D6E46F5"
            }
          },
          {
            "test": {
              "id": "641E71B8-58B9-11E5-910C-65A7C0F9A297",
              "name": "Helsingin kauppakorkeakoulu",
              "phone": "1234567890",
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

    # Get a single test entity
    stub_request(:get, "https://stage-api.global-registry.org/entities/219A7C20-58B8-11E5-B850-6BAC9D6E46F5").
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "entity": {
          "test": {
            "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
            "name": "Institute of Technology",
            "phone": "+1-234-567-8901",
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

    # Get page 3 of "test" entities, this page doesn't exist because page 2 was the last page
    stub_request(:get, "https://stage-api.global-registry.org/entities?entity_type=test&page=3").
      with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => %({"entities":[],"meta":{"page":3,"next_page":false,"from":4,"to":5}}), :headers => {})

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



    # Get test entity types
    stub_request(:get,  "https://stage-api.global-registry.org/entity_types?field_type=entity&page=1&per_page=100").
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "entity_types":[{
          "id":"e9b8aaf0-1994-11e5-a76d-12c37bb2d521",
          "name":"position_role",
          "description":"Root level position_role entity type to store enum values",
          "data_visibility":"public",
          "enum_values":["Team Member","Team Leader","Not Applicable"],
          "field_type":"enum_values",
          "is_editable":false,
          "unique_value":false
          },
          {
          "id":"a5499c9a-d556-11e3-af5a-12725f8f377c",
          "name":"ministry",
          "description":"Entity object to hold information about a ministry",
          "data_visibility":"public",
          "relationships":
                 [{"relationship_type":{
                   "id":"7cd27938-d558-11e3-868a-12725f8f377c",
                   "relationship_entity_type_id":"b4c69f8e-db86-11e3-acf9-12725f8f377c",
                   "relationship1":{"entity_type":"person","relationship_name":"person"},
                   "relationship2":{"entity_type":"ministry","relationship_name":"ministry"}
                   }}],
          "fields":[
              {"id":"97d1e40e-d557-11e3-8ea8-12725f8f377c",
              "name":"is_active",
              "data_visibility":"public",
              "field_type":"boolean",
              "description": "Your official given name.",
              "is_editable":false,
              "unique_value":false,
              "fields":[
                  {"id":"97d1e40e-d557-11e3-8ea8-12725f8f377c",
                  "name":"is_active",
                  "data_visibility":"public",
                  "description": "Your official given name.",
                  "field_type":"boolean",
                  "is_editable":false,
                  "unique_value":false
                  },{
                  "id":"addb95ba-d557-11e3-8422-12725f8f377c",
                  "name":"sp_phone",
                  "data_visibility":"public",
                  "description": "Your official given name.",
                  "field_type":"string",
                  "is_editable":false,
                  "unique_value":false
                  }]
              }]
          }
        ],
        "meta": {
          "page": 1,
          "next_page": false,
          "from": 1,
          "to": 2
        }
      }))

  stub_request(:get,  "https://stage-api.global-registry.org/entity_types?field_type=entity&page=2&per_page=100").
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "entity_types":[{
          "id":"e9b8aaf0-1994-11e5-a76d-12c37bb2d521",
          "name":"position_role",
          "description":"Root level position_role entity type to store enum values",
          "data_visibility":"public",
          "enum_values":["Team Member","Team Leader","Not Applicable"],
          "field_type":"enum_values",
          "is_editable":false,
          "unique_value":false
          },
          {
          "id":"e9b8aaf0-1994-11e5-a76d-12c37bb2d521",
          "name":"position_role",
          "description":"Root level position_role entity type to store enum values",
          "data_visibility":"public",
          "enum_values":["Team Member","Team Leader","Not Applicable"],
          "field_type":"enum_values",
          "is_editable":false,
          "unique_value":false
          }
        ],
        "meta": {
          "page": 1,
          "next_page": false,
          "from": 1,
          "to": 2
        }
      }))

    stub_request(:get, "https://stage-api.global-registry.org/relationship_types").
      with(headers: {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
      to_return(status: 200, headers: {}, body: %({
        "relationship_types": [
            {
                "fields": [],
                "id": "2c82ceda-346a-11e4-a7c1-2344fd6feb74",
                "relationship1": {
                    "entity_type": "position_role",
                    "relationship_name": "boss"
                },
                "relationship2": {
                    "entity_type": "position_role",
                    "relationship_name": "employee"
                },
                "relationship_entity_type_id": "2c8244ec-346a-11e4-a7c0-e3d3f75d53d0",
                "is_editable": true
            },
            {
                "id": "2c82ceda-346a-11e4-a7c1-2344fd6feb74",
                "relationship1": {
                    "entity_type": "person",
                    "relationship_name": "husband"
                },
                "relationship2": {
                    "entity_type": "person",
                    "relationship_name": "wife"
                },
                "relationship_entity_type_id": "2c8244ec-346a-11e4-a7c0-e3d3f75d53d0",
                "is_editable": true
            }
        ],
        "meta": {
            "from": 1,
            "page": 1,
            "to": 2,
            "total_pages": 10
        }
    }))

stub_request(:get, "https://stage-api.global-registry.org/measurement_types?filters%5Brelated_entity_type_id%5D=a0xxs00a-sx033").
  with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :headers => {}, body: %({
    "measurement_types": [
            {
                "fields": [],
                "id": "2c82ceda-346a-11e4-a7c1-2344fd6feb74",
                "relationship1": {
                    "entity_type": "position_role",
                    "relationship_name": "boss"
                },
                "relationship2": {
                    "entity_type": "position_role",
                    "relationship_name": "employee"
                },
                "relationship_entity_type_id": "2c8244ec-346a-11e4-a7c0-e3d3f75d53d0",
                "is_editable": true
            },
            {
                "id": "2c82ceda-346a-11e4-a7c1-2344fd6feb74",
                "relationship1": {
                    "entity_type": "person",
                    "relationship_name": "husband"
                },
                "relationship2": {
                    "entity_type": "person",
                    "relationship_name": "wife"
                },
                "relationship_entity_type_id": "2c8244ec-346a-11e4-a7c0-e3d3f75d53d0",
                "is_editable": true
            }
        ],
        "meta": {
            "from": 1,
            "page": 1,
            "to": 2,
            "total_pages": 10
        }
    }))

## Create entity types

  stub_request(:post, "https://stage-api.global-registry.org/entity_types").
  with(:body => "{\"entity_type\":{\"name\":\"entity_type_1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'98', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "{\"entity_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"name_one\",\"description\":\"a good description\",\"field_type\":\"string\",\"client_integration_id\":\"1\"}}", :headers => {})

## Update entity types

stub_request(:put, "https://stage-api.global-registry.org/entity_types/a0xxs00a-sx033").
  with(:body => "{\"entity_type\":{\"name\":\"entity_type_1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'98', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "{\"entity_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"name_one\",\"description\":\"a good description\",\"field_type\":\"string\",\"client_integration_id\":\"1\"}}", :headers => {})

## Create relationship types

  stub_request(:post, "https://stage-api.global-registry.org/relationship_types").
  with(:body => "{\"relationship_type\":{\"entity_type1_id\":\"ss5sasxxs5\",\"relationship1\":\"father\",\"entity_type2_id\":\"ss5sasxxs5\",\"relationship2\":\"son\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'132', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "{\"relationship_type\":{\"id\":\"0000-0000-0000-0001\",\"client_integration_id\":\"5197-11E5-B6A3-3087D5902334\",\"entity_type1_id\":\"ss5sasxxs5\",\"relationship1\":\"father\",\"entity_type2_id\":\"ss5sasxxs5\",\"relationship2\":\"son\"}}", :headers => {})

## Update relationship types

  stub_request(:put, "https://stage-api.global-registry.org/relationship_types/a0xxs00a-sx033").
  with(:body => "{\"relationship_type\":{\"entity_type1_id\":\"ss5sasxxs5\",\"relationship1\":\"father\",\"entity_type2_id\":\"ss5sasxxs5\",\"relationship2\":\"son\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'132', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "{\"relationship_type\":{\"id\":\"0000-0000-0000-0001\",\"client_integration_id\":\"5197-11E5-B6A3-3087D5902334\",\"entity_type1_id\":\"ss5sasxxs5\",\"relationship1\":\"father\",\"entity_type2_id\":\"ss5sasxxs5\",\"relationship2\":\"son\"}}", :headers => {})

## Create measurement types

 stub_request(:post, "https://stage-api.global-registry.org/measurement_types").
  with(:body => "{\"measurement_type\":{\"name\":\"new_staff\",\"description\":\"A description\",\"perm_link\":\"LMI\",\"frequency\":\"1\",\"unit\":\"people\",\"related_entity_type_id\":\"12sdasda12\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'159', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "{\"measurement_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"New Staff\",\"description\":\"A description\",\"perm_link\":\"LMI\",\"client_integration_id\":\"5197-11E5-B6A3-3087D5902334\"}}", :headers => {})

## Update measurement types

  stub_request(:put, "https://stage-api.global-registry.org/measurement_types/ss0066sx").
  with(:body => "{\"measurement_type\":{\"name\":\"new_staff\",\"description\":\"A description\",\"perm_link\":\"LMI\",\"frequency\":\"1\",\"unit\":\"people\",\"related_entity_type_id\":\"12sdasda12\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'159', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "{\"measurement_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"New Staff\",\"description\":\"A description\",\"perm_link\":\"LMI\",\"client_integration_id\":\"5197-11E5-B6A3-3087D5902334\"}}", :headers => {})
  
## Create Subscriptions

  stub_request(:post, "https://stage-api.global-registry.org/subscriptions").
  with(:body => "{\"subscription\":{\"entity_type_id\":\"0000-00023-00\",\"endpoint\":\"http://test.host\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'81', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "", :headers => {})

## Delete Subscriptions

  stub_request(:delete, "https://stage-api.global-registry.org/subscriptions/0000-0000-0001").
  with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => "", :headers => {})

## Search subscriptions

  stub_request(:get, "https://stage-api.global-registry.org/subscriptions").
  with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => %({
    "subscriptions": [
            {
                "id": "2c82ceda-346a-11e4-a7c1-2344fd6feb74",
                "entity_type_id": "2c8244ec-346a-11e4-a7c0-e3d3f75d53d0",
                "endpoint": "test.com"
            }
        ],
        "meta": {
            "from": 1,
            "page": 1,
            "to": 1,
            "total_pages": 1
        }
    }))

  ## Get all systems

  stub_request(:get, "https://stage-api.global-registry.org/systems").
  with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => %({
    "systems": [
        {
            "id": "4686168e-3f37-11e4-a741-12c37bb2d521",
            "name": "mark knutsen",
            "created_at": "2014-09-18T13:25:36.678Z",
            "updated_at": "2015-04-09T18:59:07.680Z",
            "contact_name": "Mark Knutsen",
            "contact_email": "mark.knutsen@cru.org",
            "permalink": "mark_knutsen"
        },
        {
            "id": "14e696a6-e443-11e4-8e77-12c37bb2d521",
            "name": "mark test",
            "created_at": "2015-04-16T14:15:49.256Z",
            "updated_at": "2015-04-16T14:16:21.523Z",
            "contact_name": "Mark Knutsen",
            "contact_email": "mark.knutsen@cru.org",
            "permalink": "mark_test"
        }
      ]
    }))

  stub_request(:get, "https://stage-api.global-registry.org/systems/0000-0000-0000-0001").
  with(:headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => %({
    "system": {
        "id": "0000-0000-0000-0001",
        "name": "mark test",
        "created_at": "2015-04-16T14:15:49.256Z",
        "updated_at": "2015-04-16T14:16:21.523Z",
        "contact_name": "Mark Knutsen",
        "contact_email": "mark.knutsen@cru.org",
        "permalink": "mark_test",
        "root": false,
        "is_trusted": false,
        "access_token": "your_access_token",
        "trusted_ips": [
            "208.31.255.33"
        ]
      }
    }))

  stub_request(:put, "https://stage-api.global-registry.org/systems/0000-0000-0000-0001").
  with(:body => "{\"system\":{\"name\":\"test system\",\"contact_name\":\"Mr test\",\"contact_email\":\"test@email.com\",\"permalink\":\"test.com\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'114', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => %({
    "system": {
        "id": "0000-0000-0000-0001",
        "name": "test system",
        "created_at": "2015-04-16T14:15:49.256Z",
        "updated_at": "2015-04-16T14:16:21.523Z",
        "contact_name": "Mr test",
        "contact_email": "test@email.com",
        "permalink": "test.com",
        "root": false,
        "is_trusted": false,
        "access_token": "your_access_token",
        "trusted_ips": [
            "208.31.255.33"
        ]
      }
    }))

  stub_request(:post, "https://stage-api.global-registry.org/systems").
  with(:body => "{\"system\":{\"name\":\"test system\",\"contact_name\":\"Mr test\",\"contact_email\":\"test@email.com\",\"permalink\":\"test.com\"}}",
       :headers => {'Accept'=>'application/json', 'Accept-Encoding'=>'gzip, deflate', 'Authorization'=>'Bearer test', 'Content-Length'=>'114', 'Content-Type'=>'application/json', 'Timeout'=>'-1', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => %({
    "system": {
        "id": "0000-0000-0000-0001",
        "name": "test system",
        "created_at": "2015-04-16T14:15:49.256Z",
        "updated_at": "2015-04-16T14:16:21.523Z",
        "contact_name": "Mr test",
        "contact_email": "test@email.com",
        "permalink": "test.com",
        "root": false,
        "is_trusted": false,
        "access_token": "your_access_token",
        "trusted_ips": [
            "208.31.255.33"
        ]
      }
    }))

  end
end

class ActiveSupport::TestCase
  include GlobalRegistryStubs
end
