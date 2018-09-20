module GlobalRegistryStubs
  def before_setup
    super

    # Search test entity
    stub_request(:get, /https:\/\/test-api.global-registry.org\/entities\?entity_type=test/).
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
        "entities": [
          {
            "test": {
              "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
              "name": "Institute of Technology",
              "phone": "+1-234-567-8901",
              "is_active": true,
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
              "is_active": true,
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

  # API responds with a 504
  stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=slow_test").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 504, headers: {})



    # Get a single test entity
    stub_request(:get, "https://test-api.global-registry.org/entities/219A7C20-58B8-11E5-B850-6BAC9D6E46F5").
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
        "entity": {
          "test": {
            "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
            "name": "Institute of Technology",
            "phone": "+1-234-567-8901",
            "is_active": true,
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
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&fields=*").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222","is_active":true}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with filters for "test" entity
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&filters%5Battribute%5D%5Bnested%5D=test&filters%5Bname%5D=Mr&filters%5Bphone%5D=1-800-TEST").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222","is_active":true}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with relationship filters
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&filters%5Bministry:relationship:role%5D=Director&filters%5Bwife:relationship%5D%5Bfirst_name%5D=wilma").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[],"meta":{"page":1,"next_page":false,"from":1,"to":1}}), :headers => {})

    # Search with order for "test" entity
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&order=name%20asc,phone%20desc").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222","is_active":true}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Search with pagination
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&page=45&per_page=76").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222","is_active":true}}],"meta":{"page":45,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Get a "test" entity
    stub_request(:get, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entity":{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}}}), :headers => {})

    # Get page 1 of "test" entities, the first page
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&page=1&fields=*").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222","is_active":true}}],"meta":{"page":1,"next_page":true,"from":1,"to":2}}), :headers => {})

    # Get page 2 of "test" entities, the last page
    stub_request(:get, "https://test-api.global-registry.org/entities?entity_type=test&page=2&fields=*").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entities":[{"test":{"id":"0000-0000-0000-0001","phone":"+1234567890","name":"Mr. Test","client_integration_id":"1234","is_active":true}},{"test":{"id":"0000-0000-0000-0002","phone":"1800TEST","name":"Count Testalot","client_integration_id":"2222","is_active":true}}],"meta":{"page":2,"next_page":false,"from":3,"to":4}}), :headers => {})



    # Delete a "test" entity
    stub_request(:delete, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({"entity":{"test":{"id":"0000-0000-0000-0001"}}}), :headers => {})

    # Create a "test" entity
    stub_request(:post, "https://test-api.global-registry.org/entities").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:post, "https://test-api.global-registry.org/entities").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"phone\":\"1800TEST\",\"name\":\"Mr. Test\",\"is_active\":null}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'103', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:post, "https://test-api.global-registry.org/entities").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"is_active\":false}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'67', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"client_integration_id\":\"1\",\"is_active\":false}}}", :headers => {})

    # Update a "test" entity
    stub_request(:put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\"}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"phone\":\"1800TEST\",\"name\":\"Mr. Test\",\"is_active\":null}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'103', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"phone\":\"1800TEST\",\"name\":\"Mr. Test\",\"is_active\":true}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'103', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":false}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'104', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"is_active\":false}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'67', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":true}}}", :headers => {})
    stub_request(:put, "https://test-api.global-registry.org/entities/0000-0000-0000-0001").
      with(:body => "{\"entity\":{\"test\":{\"client_integration_id\":\"1\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\"}}}",
           :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'86', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => "{\"entity\":{\"test\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Mr. Test\",\"phone\":\"1800TEST\",\"client_integration_id\":\"1\",\"is_active\":null}}}", :headers => {})


    # Get test entity types
    stub_request(:get, /https:\/\/test-api.global-registry.org\/entity_types\?field_type=entity*/).
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
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
          {"id":"0ffb3164-2044-11e5-a05f-12c37bb2d521",
          "name":"target_area_ministry_presence",
          "description":"Root level target_area_ministry_presence entity type to store enum values",
          "data_visibility":"public",
          "enum_values":["Unknown","No Presence","Ministry","Movement","Partner"]
          ,"field_type":"enum_values",
          "is_editable":false,
          "unique_value":false
          },{
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
              "is_editable":false,
              "unique_value":false,
              "fields":[
              {"id":"00c6011a-0cfe-11e4-92e7-12c37bb2d521","name":"zip","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false},
              {"id":"00cdf85c-0cfe-11e4-9c68-12c37bb2d521","name":"contact_name","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false},
              {"id":"00d4e3c4-0cfe-11e4-a2d7-12c37bb2d521","name":"contact_relationship","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false},
              {"id":"b7dacf0a-18b3-11e4-977d-12c37bb2d521","name":"active","data_visibility":"public","field_type":"boolean","is_editable":false,"unique_value":false},
              {"id":"00dbb820-0cfe-11e4-8c69-12c37bb2d521","name":"address_type","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false},
              {"id":"00e2a81a-0cfe-11e4-b46e-12c37bb2d521","name":"room","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false},
              {"id":"00e988a6-0cfe-11e4-bfa4-12c37bb2d521","name":"line3","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false},
              {"id":"00f0936c-0cfe-11e4-aa8f-12c37bb2d521","name":"line4","data_visibility":"public","field_type":"string","is_editable":false,"unique_value":false}
              ]},{
              "id":"adbf4b30-d557-11e3-bbc8-12725f8f377c",
              "name":"note",
              "data_visibility":"public",
              "field_type":"string",
              "is_editable":false,
              "unique_value":false
              },{
              "id":"addb95ba-d557-11e3-8422-12725f8f377c",
              "name":"sp_phone",
              "data_visibility":"public",
              "field_type":"string",
              "is_editable":false,
              "unique_value":false
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

    stub_request(:get, "https://test-api.global-registry.org/measurement_types").
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
        "measurement_types": [
            {
              "id": "672fbfc0-e0e6-11e3-8f08-12725f8f377c",
              "name": "ActualReportingNodes",
              "description": null,
              "perm_link": "LMI",
              "frequency": "monthly",
              "unit": "people",
              "related_entity_type_id": "896e2bae-e0d6-11e3-920e-12725f8f377c",
              "measurements": [
                {
                  "id": "00d914dc-3fdd-11e4-ad72-12c37bb2d521",
                  "period": "2014-07",
                  "value": "3.0",
                  "related_entity_id": "332a1aec-f1fb-11e3-bcb3-12725f8f377c"
                }
              ]
            },
            {
              "id": "678f31bc-e0e6-11e3-9c76-12725f8f377c",
              "name": "PossibleReportingNodes",
              "description": null,
              "perm_link": "LMI",
              "frequency": "monthly",
              "unit": "people",
              "related_entity_type_id": "896e2bae-e0d6-11e3-920e-12725f8f377c",
              "measurements": [
                {
                  "id": "0a9e188c-3fdd-11e4-b129-12c37bb2d521",
                  "period": "2014-07",
                  "value": "3.0",
                  "related_entity_id": "332a1aec-f1fb-11e3-bcb3-12725f8f377c"
                }
              ]
            }
          ],
          "meta": {
              "from": 1,
              "page": 1,
              "to": 2,
              "total_pages": 10
          }
    }))

    stub_request(:get, "https://test-api.global-registry.org/measurement_types?filters%5Brelated_entity_type_id%5D=a0xxs00a-sx033").
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
        "measurement_types": [
            {
              "id": "672fbfc0-e0e6-11e3-8f08-12725f8f377c",
              "name": "ActualReportingNodes",
              "description": null,
              "perm_link": "LMI",
              "frequency": "monthly",
              "unit": "people",
              "related_entity_type_id": "896e2bae-e0d6-11e3-920e-12725f8f377c",
              "measurements": [
                {
                  "id": "00d914dc-3fdd-11e4-ad72-12c37bb2d521",
                  "period": "2014-07",
                  "value": "3.0",
                  "related_entity_id": "332a1aec-f1fb-11e3-bcb3-12725f8f377c"
                }
              ]
            },
            {
              "id": "678f31bc-e0e6-11e3-9c76-12725f8f377c",
              "name": "PossibleReportingNodes",
              "description": null,
              "perm_link": "LMI",
              "frequency": "monthly",
              "unit": "people",
              "related_entity_type_id": "896e2bae-e0d6-11e3-920e-12725f8f377c",
              "measurements": [
                {
                  "id": "0a9e188c-3fdd-11e4-b129-12c37bb2d521",
                  "period": "2014-07",
                  "value": "3.0",
                  "related_entity_id": "332a1aec-f1fb-11e3-bcb3-12725f8f377c"
                }
              ]
            }
          ],
          "meta": {
              "from": 1,
              "page": 1,
              "to": 2,
              "total_pages": 10
          }
    }))

    stub_request(:get, "https://test-api.global-registry.org/measurement_types?filters%5Bpage%5D=3&filters%5Bper_page%5D=15").
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
    "measurement_types": [
            {
              "id": "672fbfc0-e0e6-11e3-8f08-12725f8f377c",
              "name": "ActualReportingNodes",
              "description": null,
              "perm_link": "LMI",
              "frequency": "monthly",
              "unit": "people",
              "related_entity_type_id": "896e2bae-e0d6-11e3-920e-12725f8f377c",
              "measurements": [
                {
                  "id": "00d914dc-3fdd-11e4-ad72-12c37bb2d521",
                  "period": "2014-07",
                  "value": "3.0",
                  "related_entity_id": "332a1aec-f1fb-11e3-bcb3-12725f8f377c"
                }
              ]
            },
            {
              "id": "678f31bc-e0e6-11e3-9c76-12725f8f377c",
              "name": "PossibleReportingNodes",
              "description": null,
              "perm_link": "LMI",
              "frequency": "monthly",
              "unit": "people",
              "related_entity_type_id": "896e2bae-e0d6-11e3-920e-12725f8f377c",
              "measurements": [
                {
                  "id": "0a9e188c-3fdd-11e4-b129-12c37bb2d521",
                  "period": "2014-07",
                  "value": "3.0",
                  "related_entity_id": "332a1aec-f1fb-11e3-bcb3-12725f8f377c"
                }
              ]
            }
        ],
        "meta": {
            "from": 10,
            "page": 5,
            "to": 12,
            "total_pages": 10
        }
}))

stub_request(:get, "https://test-api.global-registry.org/relationship_types").
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
    "relationship_types": [
        {
            "fields": [],
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
        "from": 10,
        "page": 5,
        "to": 12,
        "total_pages": 10
    }
}))

stub_request(:get,  "https://test-api.global-registry.org/relationship_types?filters%5Bpage%5D=3&filters%5Bper_page%5D=15").
      with(headers: {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(status: 200, headers: {}, body: %({
    "relationship_types": [
        {
            "fields": [],
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
        "from": 10,
        "page": 5,
        "to": 12,
        "total_pages": 10
    }
}))

## Create entity types

stub_request(:post, "https://test-api.global-registry.org/entity_types").
  with(:body => "{\"entity_type\":{\"name\":\"entity_type_1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'98', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => "{\"entity_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Entity Type 1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}", :headers => {})

  stub_request(:post, "https://test-api.global-registry.org/entity_types").
  with(:body => "{\"entity_type\":{\"name\":\"entity_type_1\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'40', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => "{\"entity_type\":{\"id\":\"0000-0000-0000-0001\"}}", :headers => {})

## Update entity types

stub_request(:put, "https://test-api.global-registry.org/entity_types/0000-0000-0000-0001").
  with(:body => "{\"entity_type\":{\"name\":\"entity_type_1\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'40', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => "{\"entity_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Entity Type 1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}", :headers => {})

stub_request(:put, "https://test-api.global-registry.org/entity_types/0000-0000-0000-0001").
  with(:body => "{\"entity_type\":{\"name\":\"entity_type_1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'98', 'Content-Type'=>'application/json'}).
   to_return(:status => 200, :body => "{\"entity_type\":{\"id\":\"0000-0000-0000-0001\",\"name\":\"Entity Type 1\",\"description\":\"a great entity type\",\"field_type\":\"string\"}}", :headers => {})

## Create relationship types

stub_request(:post, "https://test-api.global-registry.org/relationship_types").
  with(:body => "{\"relationship_type\":{\"entity_type1_id\":\"0000-1212\",\"relationship1\":\"person\",\"entity_type2_id\":\"0000-1212\",\"relationship2\":\"person\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'133', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => '{"relationship_type":{"id":"0000-0000-0000-0001", "entity_type1_id": "0000-1212", "relationship1": "person", "entity_type2_id": "0000-1212", "relationship2": "person"}}', :headers => {})


## Update relationship types

stub_request(:put, "https://test-api.global-registry.org/relationship_types/0000-0000-0000-0001").
  with(:body => "{\"relationship_type\":{\"entity_type1_id\":\"0000-1212\",\"relationship1\":\"person\",\"entity_type2_id\":\"0000-1212\",\"relationship2\":\"person\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'133', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => '{"relationship_type":{"id":"0000-0000-0000-0001", "entity_type1_id": "0000-1212", "relationship1": "person", "entity_type2_id": "0000-1212", "relationship2": "person"}}', :headers => {})

## Create measurement types

stub_request(:post, "https://test-api.global-registry.org/measurement_types").
  with(:body => "{\"measurement_type\":{\"name\":\"new_staff\",\"perm_link\":\"LMI\",\"frequency\":\"1\",\"unit\":\"people\",\"description\":\"A description\",\"related_entity_type_id\":\"A009W234XXT\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'160', 'Content-Type'=>'application/json'}).
    to_return(:status => 200, :body => '{"measurement_type":{"id":"0000-0000-0000-0001", "name": "New Staff","perm_link":"LMI","description":"A description"}}', :headers => {})

stub_request(:post, "https://test-api.global-registry.org/measurement_types").
  with(:body => "{\"measurement_type\":{\"name\":\"new_staff\",\"frequency\":\"1\",\"unit\":\"people\",\"perm_link\":\"LMI\",\"related_entity_type_id\":\"A009W234XXT\",\"description\":\"A description\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'160', 'Content-Type'=>'application/json'}).
      to_return(:status => 200, :body => '{"measurement_type":{"id":"0000-0000-0000-0001", "name": "New Staff","perm_link":"LMI","description":"A description"}}', :headers => {})


## Update measurement types

stub_request(:put, "https://test-api.global-registry.org/measurement_types/0000-0000-0000-0001").
  with(:body => "{\"measurement_type\":{\"frequency\":\"1\",\"unit\":\"people\",\"name\":\"new_staff\",\"related_entity_type_id\":\"A009W234XXT\",\"perm_link\":\"LMI\",\"description\":\"A description\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'160', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => '{"measurement_type":{"id":"0000-0000-0000-0001", "name": "New Staff","perm_link":"LMI","description":"A description"}}', :headers => {})

stub_request(:put, "https://test-api.global-registry.org/measurement_types/0000-0000-0000-0001").
  with(:body => "{\"measurement_type\":{\"name\":\"new_staff\",\"frequency\":\"1\",\"unit\":\"people\",\"perm_link\":\"LMI\",\"related_entity_type_id\":\"A009W234XXT\",\"description\":\"A description\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'160', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => '{"measurement_type":{"id":"0000-0000-0000-0001", "name": "New Staff","perm_link":"LMI","description":"A description"}}', :headers => {})

## Get ALL Subscriptions

  stub_request(:get, "https://test-api.global-registry.org/subscriptions").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
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

## Create Subscriptions

  stub_request(:post, "https://test-api.global-registry.org/subscriptions").
  with(:body => "{\"subscription\":{\"entity_type_id\":\"672fbfc0-e0e6-11e3-8f08-12725f8f377c\",\"endpoint\":\"test.com\"}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'96', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => "", :headers => {})

## Delete Subscription

  stub_request(:delete, "https://test-api.global-registry.org/subscriptions/672fbfc0-e0e6-11e3-8f08-12725f8f377c").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
  to_return(:status => 200, :body => "", :headers => {})

## Get all systems

  stub_request(:get, "https://test-api.global-registry.org/systems").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
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

  stub_request(:get, "https://test-api.global-registry.org/systems?limit=6&offset=0").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
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
        },
        {
            "id": "14e696a6-e443-11e4-8e77-12c37bb2d521",
            "name": "mark test",
            "created_at": "2015-04-16T14:15:49.256Z",
            "updated_at": "2015-04-16T14:16:21.523Z",
            "contact_name": "Mark Knutsen",
            "contact_email": "mark.knutsen@cru.org",
            "permalink": "mark_test"
        },
        {
            "id": "14e696a6-e443-11e4-8e77-12c37bb2d521",
            "name": "mark test",
            "created_at": "2015-04-16T14:15:49.256Z",
            "updated_at": "2015-04-16T14:16:21.523Z",
            "contact_name": "Mark Knutsen",
            "contact_email": "mark.knutsen@cru.org",
            "permalink": "mark_test"
        },
        {
            "id": "14e696a6-e443-11e4-8e77-12c37bb2d521",
            "name": "mark test",
            "created_at": "2015-04-16T14:15:49.256Z",
            "updated_at": "2015-04-16T14:16:21.523Z",
            "contact_name": "Mark Knutsen",
            "contact_email": "mark.knutsen@cru.org",
            "permalink": "mark_test"
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

## Get one system

  stub_request(:get, "https://test-api.global-registry.org/systems/0000-0000-0000-0001").
  with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
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

    ## Get deadbeef system
    stub_request(:get, "https://test-api.global-registry.org/systems/deadbeef-dead-beef-dead-beefdeadbeef").
      with(:headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test'}).
      to_return(:status => 200, :body => %({
        "system": {
            "id": "0000-0000-0000-0001",
            "name": "dead beef system",
            "created_at": "2015-04-16T14:15:49.256Z",
            "updated_at": "2015-04-16T14:16:21.523Z",
            "contact_name": "Dead Beef",
            "contact_email": "dead.beef@cru.org",
            "permalink": "dead_beef_test",
            "root": false,
            "is_trusted": false,
            "access_token": "your_access_token",
            "trusted_ips": [
                "208.31.255.33"
            ]
          }
        }))

  ## Create System

   stub_request(:post, "https://test-api.global-registry.org/systems").
  with(:body => "{\"system\":{\"name\":\"system name\",\"permalink\":\"test.com\",\"root\":false}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'69', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => %({
    "system": {
        "id": "0000-0000-0000-0001",
        "name": "system name",
        "created_at": "2015-04-16T14:15:49.256Z",
        "updated_at": "2015-04-16T14:16:21.523Z",
        "contact_name": "Mark Knutsen",
        "contact_email": "mark.knutsen@cru.org",
        "permalink": "test.com",
        "root": false,
        "is_trusted": false,
        "access_token": "your_access_token",
        "trusted_ips": [
            "208.31.255.33"
        ]
      }
    }))

  ## Update System

 stub_request(:put, "https://test-api.global-registry.org/systems/0000-0000-0000-0001").
  with(:body => "{\"system\":{\"name\":\"system name\",\"permalink\":\"test.com\",\"root\":false}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'69', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => %({
    "system": {
        "id": "0000-0000-0000-0001",
        "name": "system name",
        "created_at": "2015-04-16T14:15:49.256Z",
        "updated_at": "2015-04-16T14:16:21.523Z",
        "contact_name": "Mark Knutsen",
        "contact_email": "mark.knutsen@cru.org",
        "permalink": "test.com",
        "root": false,
        "is_trusted": false,
        "access_token": "your_access_token",
        "trusted_ips": [
            "208.31.255.33"
        ]
      }
    }))

  ## Reset access token

  stub_request(:post, "https://test-api.global-registry.org/systems/reset_access_token?id=0000-0000-0000-0001").
  with(:body => "null",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'4', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => %({
    "system": {
        "id": "0000-0000-0000-0001",
        "name": "system name",
        "created_at": "2015-04-16T14:15:49.256Z",
        "updated_at": "2015-04-16T14:16:21.523Z",
        "contact_name": "Mark Knutsen",
        "contact_email": "mark.knutsen@cru.org",
        "permalink": "test.com",
        "root": false,
        "is_trusted": false,
        "access_token": "121213D12",
        "trusted_ips": [
            "208.31.255.33"
        ]
      }
    }))

  stub_request(:post, "https://test-api.global-registry.org/entities").
  with(:body => "{\"entity\":{\"_enum_values\":{\"search_engine\":[\"random_engine\",\"other_random_engine\"]}}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'85', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => "", :headers => {})

  stub_request(:post, "https://test-api.global-registry.org/entities").
  with(:body => "{\"entity\":{\"person\":{\"first_name\":\"test\",\"last_name\":\"name\",\"gsw_access\":false,\"global_leader\":false,\"client_integration_id\":\"1\",\"authentication\":{\"key_guid\":\"FF223AZCS44XCS\"}}}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Type'=>'application/json'}).
   to_return(status: 200, headers: {}, body: %({
        "entity": {
          "test": {
            "id": "219A7C20-58B8-11E5-B850-6BAC9D6E46F5",
            "first_name": "test",
            "last_name": "name",
             "gsw_access": "false",
            "global_leader": "false",
            "client_integration_id": "400BF486-58B8-11E5-9BB3-6BAC9D6E46F5",
            "authentication": {
              "key_guid": "FF223AZCS44XCS"
            }
          }
        }
      }))

  stub_request(:post, "https://test-api.global-registry.org/entities").
  with(:body => "{\"entity\":{\"test\":{\"name\":\"Mr. Test\",\"phone\":\"1-800-TEST-MEYO\",\"client_integration_id\":\"12121\",\"wife:relationship\":{\"person\":\"77d483f4-508c-11e4-b8da-1fd48c4c6c72\",\"client_integration_id\":\"44\"}}}}",
       :headers => {'Accept'=>'application/json', 'Authorization'=>'Bearer test', 'Content-Length'=>'196', 'Content-Type'=>'application/json'}).
  to_return(:status => 200, :body => "", :headers => {})

  end
end

class MiniTest::Test
  include GlobalRegistryStubs
end
