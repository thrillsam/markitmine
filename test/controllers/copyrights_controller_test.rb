require 'test_helper'

class CopyrightsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @copyright = copyrights(:one)
  end

  test "should get index" do
    get copyrights_url
    assert_response :success
  end

  test "should get new" do
    get new_copyright_url
    assert_response :success
  end

  test "should create copyright" do
    assert_difference('Copyright.count') do
      post copyrights_url, params: { copyright: { image: @copyright.image, name: @copyright.name } }
    end

    assert_redirected_to copyright_url(Copyright.last)
  end

  test "should show copyright" do
    get copyright_url(@copyright)
    assert_response :success
  end

  test "should get edit" do
    get edit_copyright_url(@copyright)
    assert_response :success
  end

  test "should update copyright" do
    patch copyright_url(@copyright), params: { copyright: { image: @copyright.image, name: @copyright.name } }
    assert_redirected_to copyright_url(@copyright)
  end

  test "should destroy copyright" do
    assert_difference('Copyright.count', -1) do
      delete copyright_url(@copyright)
    end

    assert_redirected_to copyrights_url
  end
end
