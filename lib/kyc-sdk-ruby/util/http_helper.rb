module KYCSdk

  module Util

    class HTTPHelper

      # KYCSdk::Util::HTTPHelper

      require "uri"
      require "open-uri"
      require "openssl"
      require "net/http"
      require "json"

      # Initialize
      #
      # Arguments:
      #   api_base_url: (String)
      #   api_key: (String)
      #   api_secret: (String)
      #   api_spec: (Boolean)
      #
      def initialize(params)
        @api_base_url = params[:api_base_url]
        @api_key = params[:api_key]
        @api_secret = params[:api_secret]
        @api_spec = params[:api_spec]
      end

      # Send POST requests
      #
      # Arguments:
      #   end_point: (String)
      #   request_params: (Hash)
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def send_post_request(endpoint, request_params)
        perform_and_handle_exceptions('u_hh_1', 'POST request failed') do
          base_params = get_base_params(endpoint, request_params)
          uri = post_api_uri(endpoint)
          http = setup_request(uri)
          r_params = base_params.merge(request_params)
          query_string = build_nested_query(r_params)
          escaped_query_string = URI.escape(query_string, '*')
          if @api_spec
            return KYCSdk::Util::Result.success({data: {request_uri: uri.to_s, request_type: 'POST', request_params: escaped_query_string}})
          else
            result = http.post(uri.path, escaped_query_string)
            return format_response(result)
          end
        end
      end

      # Send GET requests
      #
      # Arguments:
      #   end_point: (String)
      #   request_params: (Hash)
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def send_get_request(endpoint, request_params)
        perform_and_handle_exceptions('u_hh_2', 'GET request Failed') do
          base_params = get_base_params(endpoint, request_params)
          r_params = base_params.merge(request_params)
          query_string = build_nested_query(r_params)
          escaped_query_string = URI.escape(query_string, '*')
          raw_url = get_api_url(endpoint) + "?" + escaped_query_string
          uri = URI(raw_url)
          if @api_spec
            return KYCSdk::Util::Result.success({data: {request_uri: uri.to_s.split("?")[0], request_type: 'GET', request_params: escaped_query_string}})
          else
            result = {}
            Timeout.timeout(15) do
              result = Net::HTTP.get_response(uri)
            end
            return format_response(result)
          end
        end
      end

      private

      def setup_request(uri)
        http = Net::HTTP.new(uri.host, uri.port)
        http.read_timeout = 15
        http.open_timeout = 15
        if uri.scheme == "https"
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        http
      end

      def get_base_params(endpoint, request_params)
        request_timestamp = Time.now.to_i.to_s
        request_params = request_params.merge("request_timestamp" => request_timestamp, "api_key" => @api_key)

        sorted_request_params = sort_param(request_params)
        request_params_str = build_nested_query(sorted_request_params)
        request_params_escaped_str = URI.escape(request_params_str, "*")
        str = endpoint + '?' + request_params_escaped_str
        signature = generate_signature(str)
        {"request_timestamp" => request_timestamp, "signature" => signature, "api_key" => @api_key}
      end

      def generate_signature(string_to_sign)
        digest = OpenSSL::Digest.new('sha256')
        signature = OpenSSL::HMAC.hexdigest(digest, @api_secret, string_to_sign)
        signature
      end

      def post_api_uri(endpoint)
        URI(@api_base_url + endpoint)
      end

      def get_api_url(endpoint)
        @api_base_url + endpoint
      end

      def build_nested_query(value, prefix = nil)
        case value
        when Array
          value.map { |v|
            build_nested_query(v, "#{prefix}[]")
          }.join("&")
        when Hash
          value.map { |k, v|
            build_nested_query(v, prefix ? "#{prefix}[#{k}]" : k)
          }.reject(&:empty?).join('&')
        # when nil
        #   "#{escape(prefix)}="
        else
          raise ArgumentError, "value must be a Hash" if prefix.nil?
          "#{escape(prefix)}=#{escape(value)}"
        end
      end

      def escape(s)
        URI.encode_www_form_component(s)
      end

      # Method which is called in service perform and handle exceptions
      #
      def perform_and_handle_exceptions(err_code = 'swt', err_message = 'Something Went Wrong', &block)
        begin
          yield if block_given?
        rescue StandardError => se
          KYCSdk::Util::Result.exception(se, {error: err_code, error_message: err_message})
        end
      end

      def sort_param(params)

        if params.is_a?(Hash)
          params = JSON.parse(params.to_json)
          data = {}
          params.sort.each do |ele|
            key = ele[0]
            val = ele[1]
            data[key] = sort_param(val)
          end

        elsif params.is_a?(Array)
          params = JSON.parse(params.to_json)
          data = []
          params.each do |ele|
            data << sort_param(ele)
          end
        else
          data = params.to_s
        end

        return data
      end

      def format_response(response)
        json_raw_response = JSON.parse(response.body)
        # If internal response
        if json_raw_response.has_key?('success') || json_raw_response.has_key?('err')
          format_internal_response(response)
        else
          format_external_response(response.code)
        end
      end

      def format_internal_response(response)
        json_raw_response = JSON.parse(response.body)
        if json_raw_response['success']
          KYCSdk::Util::Result.success(
              {
                  data: json_raw_response['data'],
                  http_code: response.code
              }
          )
        else
          err_data = json_raw_response['err']
          KYCSdk::Util::Result.error(
              {
                  error: err_data['code'],
                  internal_id: err_data['internal_id'],
                  error_message: err_data['msg'],
                  error_data: err_data['error_data'],
                  http_code: response.code
              }
          )
        end
      end

      def format_external_response(response_code)
        case response_code.to_i
          when 502
            code = 'BAD_GATEWAY'
            internal_id = 'SDK(BAD_GATEWAY)'
            message = 'Something went wrong.'
          when 503
            code = 'SERVICE_UNAVAILABLE'
            internal_id = 'SDK(SERVICE_UNAVAILABLE)'
            message = 'API under maintenance.'
          when 504
            code = 'GATEWAY_TIMEOUT'
            internal_id = 'SDK(GATEWAY_TIMEOUT)'
            message = 'Request timed out.'
          else
            code = 'SOMETHING_WENT_WRONG'
            internal_id = 'SDK(SOMETHING_WENT_WRONG)'
            message = 'Something went wrong.'
        end
        KYCSdk::Util::Result.error(
            {
                error: code,
                internal_id: internal_id,
                error_message: message,
                http_code: response_code
            }
        )
      end

    end

  end

end
