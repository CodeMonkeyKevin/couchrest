module RestClient
  class Request
    class MockNetHTTPResponse
      attr_reader :body, :headers, :status
      alias_method :code, :status

      def initialize(body, status, headers)
        @body = body
        @status = status
        @headers = headers
      end
    end

    def self.mod_execute(args, & block)
      begin
        new(args).execute(& block)
      rescue RestClient::ExceptionWithResponse => e
        case e.class.to_s
        when "RestClient::ResourceNotFound"
          return MockNetHTTPResponse.new(e.http_body, e.http_code, {})
        when "RestClient::Conflict"
          return MockNetHTTPResponse.new(e.http_body, e.http_code, {})
        when "RestClient::PreconditionFailed"
          return MockNetHTTPResponse.new(e.http_body, e.http_code, {})
        else
          return e
        end
      end
    end
  end
end
