require_relative "../../../lib/ost-kyc-sdk-ruby/util"
require_relative "../../../lib/ost-kyc-sdk-ruby/saas"
require "test/unit"
require_relative "../../../lib/config"

class UserTest < Test::Unit::TestCase

  def user_obj
    @user_obj ||= Config::OST_SDK.services.users
  end

  def test_user_get
    result = user_obj.get(id: ENV['USER_ID'])
    assert_equal(result.success?, true)
  end

  def test_user_get_with_zero_as_user_id
    result = user_obj.get(id: 0)
    assert_equal(result.success?, false)
  end

  def test_user_get_with_null_as_user_id
    assert_raise(RuntimeError) {
      user_obj.get(id: "")
    }
  end

  def test_user_list_with_total_entry_in_meta
    params = {order: 'asc', limit: 1, filters: {is_kyc_submitted: false}}
    result = user_obj.list(params)
    assert_equal(result.data["meta"]["next_page_payload"]["limit"], 1)
    assert_equal(result.data["meta"]["next_page_payload"]["filters"]["is_kyc_submitted"], "false")
  end

  def test_user_create
    unique_email = "usertest+#{Time.now.to_i}_#{RUBY_VERSION}@ost.com"
    result = user_obj.create(email: unique_email)
    assert_equal(result.success?, true)
  end

  def test_user_list
    result = user_obj.list()
    assert_equal(result.success?, true)
  end


end