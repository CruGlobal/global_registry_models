require 'test_helper'

class GlobalRegistryModelsCollectionTest < Minitest::Test

  def test_new
    collection = GlobalRegistryModels::Collection.new meta: {}, list: [1, 2, 3]
    assert_instance_of GlobalRegistryModels::Collection, collection
  end

  def test_each
    counter = 0
    collection = test_collection_first_page
    collection.each do |entity|
      assert entity.present?
      assert collection.all.include?(entity)
      counter += 1
    end
    assert_equal 2, counter
  end

  def test_order
    assert_equal "Count Testalot", test_collection_first_page.order(:name).first.name
  end

  def test_all
    assert_equal 2, test_collection_first_page.all.size
  end

  def test_page
    assert_equal 1, test_collection_first_page.page
    assert_equal 2, test_collection_last_page.page
  end

  def test_last_page?
    assert_equal false, test_collection_first_page.last_page?
    assert_equal true, test_collection_last_page.last_page?
  end

  def test_first_page?
    assert_equal true, test_collection_first_page.first_page?
    assert_equal false, test_collection_last_page.first_page?
  end

  def test_next_page
    assert_equal 2, test_collection_first_page.next_page
    assert_nil test_collection_last_page.next_page
  end

  def test_prev_page
    assert_nil test_collection_first_page.prev_page
    assert_equal 1, test_collection_last_page.prev_page
  end

  def test_from
    assert_equal 1, test_collection_first_page.from
    assert_equal 3, test_collection_last_page.from
  end

  def test_to
    assert_equal 2, test_collection_first_page.to
    assert_equal 4, test_collection_last_page.to
  end

  def test_per
    assert_equal 2, test_collection_first_page.per
    assert_equal 2, test_collection_last_page.per
  end

  def test_to_csv
    assert_equal <<-CSV.strip_heredoc, test_collection_first_page.to_csv
      client_integration_id,id,is_active,name,phone
      1234,0000-0000-0000-0001,true,Mr. Test,+1234567890
      2222,0000-0000-0000-0002,true,Count Testalot,1800TEST
    CSV
  end

  private

    def test_collection_first_page
      GlobalRegistryModels::Entity::Test.search page: 1
    end

    def test_collection_last_page
      GlobalRegistryModels::Entity::Test.search page: 2
    end

end
