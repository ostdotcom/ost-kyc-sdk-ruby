module OstKycSdkRuby

  module Saas

    class UserKycDetail < OstKycSdkRuby::Saas::Base

      # Initialize
      #
      # Arguments:
      #   api_base_url: (String)
      #   api_key: (String)
      #   api_secret: (String)
      #   api_spec: (Boolean)
      #
      def initialize(params)
        super
        @url_prefix = '/api/v2/users-kyc-detail'
      end

      # Get an existing User Kyc Detail
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def get(params)
        http_helper.send_get_request("#{@url_prefix}/#{get_user_id!(params)}", params)
      end

    end

  end

end
