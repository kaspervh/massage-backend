require 'test_helper'

class WorkDaysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @work_day = work_days(:one)
  end

  test "should get index" do
    get work_days_url, as: :json
    assert_response :success
  end

  test "should create work_day" do
    assert_difference('WorkDay.count') do
      post work_days_url, params: { work_day: { end_time: @work_day.end_time, start_time: @work_day.start_time, user_id: @work_day.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show work_day" do
    get work_day_url(@work_day), as: :json
    assert_response :success
  end

  test "should update work_day" do
    patch work_day_url(@work_day), params: { work_day: { end_time: @work_day.end_time, start_time: @work_day.start_time, user_id: @work_day.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy work_day" do
    assert_difference('WorkDay.count', -1) do
      delete work_day_url(@work_day), as: :json
    end

    assert_response 204
  end
end
