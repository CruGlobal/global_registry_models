require 'test_helper'

class TargetAreaTest < ActiveSupport::TestCase

  test '#to_s' do
    target_area = Entity::TargetArea.new(id: '1234-ABCD', name: 'Tester Campus')
    assert_equal 'Tester Campus', target_area.to_s
  end

end
