module KYCSdk

  module Saas

    class Base

      include KYCSdk::Util::ServicesHelper

      attr_reader :http_helper

      # KYCSdk::Saas::Base

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

        @http_helper = KYCSdk::Util::HTTPHelper.new(params)

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
      def get_id!(params)
        if params.has_key?(:id)
          id = params[:id]
          params.delete(:id)
        elsif params.has_key?('id')
          id = params['id']
          params.delete('id')
        else
          fail "id missing in request params"
        end
        id
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
        if params.has_key?(:user_id)
          user_id = params[:user_id]
          params.delete(:user_id)
        elsif params.has_key?('user_id')
          user_id = params['user_id']
          params.delete('user_id')
        else
          fail "user_id missing in request params"
        end
        user_id
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

    end

  end

end
