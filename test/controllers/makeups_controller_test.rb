require 'test_helper'

class MakeupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @makeup = makeups(:one)
  end

  test "should get index" do
    get makeups_url
    assert_response :success
  end

  test "should get new" do
    get new_makeup_url
    assert_response :success
  end

  test "should create makeup" do
    assert_difference('Makeup.count') do
      post makeups_url, params: { makeup: { st: @makeup.st } }
    end

    assert_redirected_to makeup_url(Makeup.last)
  end

  test "should show makeup" do
    get makeup_url(@makeup)
    assert_response :success
  end

  test "should get edit" do
    get edit_makeup_url(@makeup)
    assert_response :success
  end

  test "should update makeup" do
    patch makeup_url(@makeup), params: { makeup: { st: @makeup.st } }
    assert_redirected_to makeup_url(@makeup)
  end

  test "should destroy makeup" do
    assert_difference('Makeup.count', -1) do
      delete makeup_url(@makeup)
    end

    assert_redirected_to makeups_url
  end
end
