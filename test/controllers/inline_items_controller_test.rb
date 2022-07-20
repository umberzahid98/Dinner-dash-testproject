# frozen_string_literal: true

require 'test_helper'

class InlineItemsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get inline_items_index_url
    assert_response :success
  end
end
