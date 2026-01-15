require "test_helper"

class HandbookControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get handbook_index_url
    assert_response :success
  end

  test "should get general_knowledge" do
    get handbook_general_knowledge_url
    assert_response :success
  end

  test "should get wk_rokan" do
    get handbook_wk_rokan_url
    assert_response :success
  end

  test "should get rig_hub" do
    get handbook_rig_hub_url
    assert_response :success
  end
end
