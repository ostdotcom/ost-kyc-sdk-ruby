require_relative "../../../lib/ost-kyc-sdk-ruby/util"
require_relative "../../../lib/ost-kyc-sdk-ruby/saas"
require "test/unit"
require_relative "../../../lib/config"

class UserKycDetailTest < Test::Unit::TestCase

  def user_kyc_detail_obj
    @user_kyc_detail_obj ||= Config::OST_SDK.services.users_kyc_detail
  end

  def test_user_kyc_detail_get
    result = user_kyc_detail_obj.get(user_id: ENV['USER_ID'])
    assert_equal(result.success?, true )
  end

end