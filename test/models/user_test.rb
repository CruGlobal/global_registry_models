require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test '#name' do
    user = users(:one)
    assert_equal 'Bob User', user.name
    user.last_name = nil
    assert_equal 'Bob', user.name
    user.first_name = nil
    assert_equal '', user.name
  end

  test '#to_s' do
    user = users(:one)
    assert_equal 'Bob User', user.to_s
    user.first_name = nil
    assert_equal 'User', user.to_s
    user.last_name = nil
    assert_equal 'bob@internet.com', user.to_s
    user.email = nil
    assert_equal 'user-one-guid-5197-11E5-B6A3-3087D5902334', user.to_s
  end

end
