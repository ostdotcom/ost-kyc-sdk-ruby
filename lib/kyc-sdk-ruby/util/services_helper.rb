module KYCSdk

  module Util

    module ServicesHelper

      # Wrapper Method which could be used to execute business logic
      # Error handling code wraps execution of business logic
      #
      # Arguments:
      #   err_code: (String)
      #   err_message: (String)
      #   block: (Proc)
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def perform_and_handle_exceptions(err_code = 'swt', err_message = 'Something Went Wrong', &block)
        begin
          yield if block_given?
        rescue StandardError => se
          KYCSdk::Util::Result.exception(se, {error: err_code, error_message: err_message, data: @params} )
        end
      end

      # Success
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def success
        success_with_data({})
      end

      # Success with data
      #
      # Arguments:
      #   data: (Hash)
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def success_with_data(data)

        # Allow only Hash data to pass ahead
        data = {} unless Util::CommonValidator.is_a_hash?(data)

        KYCSdk::Util::Result.success({data: data})

      end

      # Error with data
      #
      # Arguments:
      #   code: (String)
      #   msg: (String)
      #   data: (Hash)
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def error_with_data(code, msg, data = {})

        KYCSdk::Util::Result.error(
            {
                error: code,
                error_message: msg,
                data: data
            }
        )

      end

      #
      # Exception with data and without action
      #
      # Arguments:
      #   e: (Exception)
      #   code: (String)
      #   msg: (String)
      #   data: (Hash optional)
      #
      # Returns:
      #   KYCSdk::Util::Result
      #
      def exception_with_data(e, code, msg, data = {})

        KYCSdk::Util::Result.exception(
            e, {
            error: code,
            error_message: msg,
            data: data
          }
        )

      end

    end

  end

end
