module OstKycSdkRuby

  module Saas

    class Validators < OstKycSdkRuby::Saas::Base

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
        @url_prefix = '/api/v2'
      end

      # Verify Ethereum Address
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def verify_ethereum_address(params)
        http_helper.send_get_request("#{@url_prefix}/ethereum-address-validation", params)
      end

    end

  end

end
