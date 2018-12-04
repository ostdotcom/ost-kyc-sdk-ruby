require_relative "../../../lib/ost-kyc-sdk-ruby/util"
require_relative "../../../lib/ost-kyc-sdk-ruby/saas"
require "test/unit"
require_relative "../../../lib/config"

class ValidatorsTest < Test::Unit::TestCase

  def validators_obj
    @validators_obj ||= Config::OST_SDK.services.validators
  end

  def test_validators_get
    result = validators_obj.verify_ethereum_address(ethereum_address: "0x7f2ED21D1702057C7d9f163cB7e5458FA2B6B7c4")
    assert_equal(result.success?, true )
  end

end