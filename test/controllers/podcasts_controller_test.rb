require "test_helper"

class PodcastsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get podcasts_new_url
    assert_response :success
  end

  test "should get create" do
    get podcasts_create_url
    assert_response :success
  end

  test "should get show" do
    get podcasts_show_url
    assert_response :success
  end
end
