require "test_helper"

class InvestigatorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @investigator = investigators(:one)
  end

  test "should get index" do
    get investigators_url
    assert_response :success
  end

  test "should get new" do
    get new_investigator_url
    assert_response :success
  end

  test "should create investigator" do
    assert_difference("Investigator.count") do
      post investigators_url, params: { investigator: { email: @investigator.email, idCard: @investigator.idCard, lastname: @investigator.lastname, name: @investigator.name } }
    end

    assert_redirected_to investigator_url(Investigator.last)
  end

  test "should show investigator" do
    get investigator_url(@investigator)
    assert_response :success
  end

  test "should get edit" do
    get edit_investigator_url(@investigator)
    assert_response :success
  end

  test "should update investigator" do
    patch investigator_url(@investigator), params: { investigator: { email: @investigator.email, idCard: @investigator.idCard, lastname: @investigator.lastname, name: @investigator.name } }
    assert_redirected_to investigator_url(@investigator)
  end

  test "should destroy investigator" do
    assert_difference("Investigator.count", -1) do
      delete investigator_url(@investigator)
    end

    assert_redirected_to investigators_url
  end
end
