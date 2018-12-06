module OstKycSdkRuby

  module Saas

    class Base

      REGEX_VALUE = /\A[0-9a-z\.\-]+\z/i

      include OstKycSdkRuby::Util::ServicesHelper

      attr_reader :http_helper

      # OstKycSdkRuby::Saas::Base

      # Initialize
      #
      # Arguments:
      #   api_base_url: (String)
      #   api_key: (String)
      #   api_secret: (String)
      #   api_spec: (Boolean)
      #
      def initialize(params)

        fail 'missing API Base URL' if params[:api_base_url].nil?
        fail 'missing API Key' if params[:api_key].nil?
        fail 'missing API Secret' if params[:api_secret].nil?

        params[:api_base_url] = sanitize_api_base_url(params[:api_base_url])

        @http_helper = OstKycSdkRuby::Util::HTTPHelper.new(params)

      end

      private

      # Get id key from params hash and delete it
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   id: (Integer)
      #
      #
      # if (null == params || !params.containsKey("id") || null == params.get("id")) {
      #             throw new MissingParameter("id");
      #         }
      def get_id!(params)
        get_value_for_key(params, "id")
      end

      # Get user_id key from params hash and delete it
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   id: (Integer)
      #
      def get_user_id!(params)
        get_value_for_key(params, "user_id")
      end

      # Get value for specific key
      #
      # Arguments:
      #   params: (Hash)
      #
      # Returns:
      #   id: (Integer)
      #
      def get_value_for_key(params, key)
        if params.has_key?(key.to_sym)
          value = params.delete(key.to_sym)
        elsif params.has_key?(key.to_s)
          value = params.delete(key.to_s)
        end
        raise "#{key.to_s} missing in request params" if value.nil?
        raise "#{key.to_s} invalid in request params" if !(is_valid_value?(value.to_s))
        value
      end

      # Sanitize API Base URL
      #
      # Arguments:
      #   params: (String)
      #
      # Returns:
      #   api_base_url: (String)
      #
      def sanitize_api_base_url(api_base_url)

        api_base_url = api_base_url.gsub(/\/$/, '') # remove trailing slash

        return api_base_url

      end

      # Is the value is valid for given key
      #
      # * Author: Puneet
      # * Date: 10/10/2017
      # * Reviewed By: Sunil
      #
      # @return [Boolean] returns a boolean
      #
      def is_valid_value?(value)
        value =~ REGEX_VALUE
      end

    end

  end

end
