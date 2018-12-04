module OstKycSdkRuby

  module Saas

    class Services

      ## OstKycSdkRuby::Saas::Services

      attr_reader :services

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

        params[:api_base_url] = params[:api_base_url].gsub(/\/$/, '') # remove trailing slash
        params[:api_spec] = false if params[:api_spec].nil?

        set_manifest(params)

      end

      private

      def set_manifest(params)

        @services = OstKycSdkRuby::Saas::Manifest.new(params)

      end

    end

  end

end
