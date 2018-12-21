require_relative "../../../lib/ost-kyc-sdk-ruby/util"
require_relative "../../../lib/ost-kyc-sdk-ruby/saas"
require "test/unit"
require_relative "../../../lib/config"

class UserKycTest < Test::Unit::TestCase

  def user_kyc_obj
    @user_kyc_obj ||= Config::OST_SDK.services.users_kyc
  end

  def test_user_kyc_get
    result = user_kyc_obj.get(user_id: ENV['USER_ID'])
    assert_equal(result.success?, true )
  end

  def test_submit_kyc
    params = {user_id: ENV['USER_ID'], first_name:'aniket',last_name:'ayachit', birthdate:'21/12/1991', country:'india', nationality:'indian', document_id_number:'arqpa7659a',document_id_file_path:'2/i/016be96da275031de2787b57c99f1471', selfie_file_path:'2/i/9e8d3a5a7a58f0f1be50b7876521aebc', residence_proof_file_path:'2/i/4ed790b2d525f4c7b30fbff5cb7bbbdb', ethereum_address: '0xdfbc84ccac430f2c0455c437adf417095d7ad68e', estimated_participation_amount:'2', street_address:'afawfveav ',city:'afawfveav', state:'afawfveav',postal_code:'afawfveav','investor_proof_files_path':['2/i/9ff6374909897ca507ba3077ee8587da', '2/i/4872730399670c6d554ab3821d63ebce']}
    result = user_kyc_obj.submit_kyc(params)
    assert_equal(result.success?, false )
  end

  def test_email_approve
    params = {user_id: ENV['USER_ID']}
    result = user_kyc_obj.email_approve(params)
    is_unprocessable_entity(result)
  end

  def test_email_deny
    params = {user_id: ENV['USER_ID']}
    result = user_kyc_obj.email_deny(params)
    is_unprocessable_entity(result)
  end

  def test_email_report_issue
    params = {user_id: ENV['USER_ID']}
    result = user_kyc_obj.email_report_issue(params)
    is_unprocessable_entity(result)
  end

  def test_user_kyc_list
    result = user_kyc_obj.list()
    assert_equal(result.success?, true )
  end

  def test_presigned_url_for_put
    params = {files: {selfie: "image/jpeg"}}
    result = user_kyc_obj.get_presigned_url_put(params)
    assert_equal(result.success?, true )
  end

  def test_presigned_url_for_post
    params = {files: {selfie: "image/jpeg"}}
    result = user_kyc_obj.get_presigned_url_post(params)
    assert_equal(result.success?, true )
  end

  def is_unprocessable_entity(result)
    if !result.success?
      assert_equal(result.error, "UNPROCESSABLE_ENTITY")
    end
  end


end