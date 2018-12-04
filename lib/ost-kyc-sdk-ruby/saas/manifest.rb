module OstKycSdkRuby

  module Saas

    class Manifest

      attr_reader :users_kyc, :users, :users_kyc_detail, :validators

      # Initialize
      #
      # Arguments:
      #   api_base_url: (String)
      #   api_key: (String)
      #   api_secret: (String)
      #   api_spec: (Boolean)
      #
      def initialize(params)

        @users = OstKycSdkRuby::Saas::Users.new(params)
        @users_kyc = OstKycSdkRuby::Saas::UsersKyc.new(params)
        @users_kyc_detail = OstKycSdkRuby::Saas::UserKycDetail.new(params)
        @validators = OstKycSdkRuby::Saas::Validators.new(params)

      end

    end

  end

end
