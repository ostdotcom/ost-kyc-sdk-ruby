module OstKycSdkRuby

  module Saas

    class UsersKyc < OstKycSdkRuby::Saas::Base

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
        @url_prefix = '/api/v2/users-kyc'
      end

      # Fetches the list of an existing Users Kyc
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def list(params = {})
        http_helper.send_get_request("#{@url_prefix}", params)
      end

      # Creates/Updates a new User Kyc
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def submit_kyc(params)
        http_helper.send_post_request("#{@url_prefix}/#{get_user_id!(params)}", params)
      end

      # Send Approve Email to User
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def email_approve(params)
        http_helper.send_post_request("#{@url_prefix}/#{get_user_id!(params)}/email/approve", params)
      end

      # Send Deny Email to User
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def email_deny(params)
        http_helper.send_post_request("#{@url_prefix}/#{get_user_id!(params)}/email/deny", params)
      end

      # Send Report Issue Email to User
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def email_report_issue(params)
        http_helper.send_post_request("#{@url_prefix}/#{get_user_id!(params)}/email/report-issue", params)
      end

      # Get an existing User Kyc
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def get(params)
        http_helper.send_get_request("#{@url_prefix}/#{get_user_id!(params)}", params)
      end

      # Get an existing Presigned URL via POST call
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def get_presigned_url_post(params = {})
        http_helper.send_get_request("#{@url_prefix}/pre-signed-urls/for-post", params)
      end

      # Get an existing Presigned URL via PUT call
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   response: (OstKycSdkRuby::Util::Result)
      #
      def get_presigned_url_put(params = {})
        http_helper.send_get_request("#{@url_prefix}/pre-signed-urls/for-put", params)
      end

    end

  end

end
