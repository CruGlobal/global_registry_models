require 'test_helper'

class CollectionTest < ActiveSupport::TestCase

  test '.new' do
    collection = Entity::Collection.new meta: {}, entities: [1, 2, 3]
    assert_instance_of Entity::Collection, collection
  end

  test '#each' do
    counter = 0
    collection = test_collection_first_page
    collection.each do |entity|
      assert entity.present?
      assert collection.all.include?(entity)
      counter += 1
    end
    assert_equal 2, counter
  end

  test '#all' do
    assert_equal 2, test_collection_first_page.all.size
  end

  test '#page' do
    assert_equal 1, test_collection_first_page.page
    assert_equal 2, test_collection_last_page.page
  end

  test '#last_page?' do
    assert_equal false, test_collection_first_page.last_page?
    assert_equal true, test_collection_last_page.last_page?
  end

  test '#first_page?' do
    assert_equal true, test_collection_first_page.first_page?
    assert_equal false, test_collection_last_page.first_page?
  end

  test '#next_page' do
    assert_equal 2, test_collection_first_page.next_page
    assert_equal nil, test_collection_last_page.next_page
  end

  test '#prev_page' do
    assert_equal nil, test_collection_first_page.prev_page
    assert_equal 1, test_collection_last_page.prev_page
  end

  test '#from' do
    assert_equal 1, test_collection_first_page.from
    assert_equal 3, test_collection_last_page.from
  end

  test '#to' do
    assert_equal 2, test_collection_first_page.to
    assert_equal 4, test_collection_last_page.to
  end

  test '#per' do
    assert_equal 2, test_collection_first_page.per
    assert_equal 2, test_collection_last_page.per
  end

  test '#to_csv' do
    assert_equal <<-CSV.strip_heredoc, test_collection_first_page.to_csv
      client_integration_id,id,name,phone
      1234,0000-0000-0000-0001,Mr. Test,+1234567890
      2222,0000-0000-0000-0002,Count Testalot,1800TEST
    CSV
  end

  private

    def test_collection_first_page
      Entity::Test.search page: 1
    end

    def test_collection_last_page
      Entity::Test.search page: 2
    end

end
