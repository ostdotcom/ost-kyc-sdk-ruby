module KYCSdk

  module Saas

    module V2

      class Services

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

          @users = KYCSdk::Saas::V2::Users.new(params)
          @users_kyc = KYCSdk::Saas::V2::UsersKyc.new(params)
          @users_kyc_detail = KYCSdk::Saas::V2::UserKycDetail.new(params)
          @validators = KYCSdk::Saas::V2::Validators.new(params)

        end

      end

    end

  end

end
