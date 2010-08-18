module CouchRest
  class HttpClient
    attr_accessor :client

    def initialize(adapter)
      adapter ||= :restclient
      @client = eval("HttpAdapter::#{adapter.to_s.capitalize}").new(CouchRest.proxy_url)
    end

    def put(uri, payload, headers = CouchRest.default_headers)
      code, body, header = @client.put(uri, payload, headers)
      return!(code, body)
    end

    def get(uri, headers = CouchRest.default_headers)
      code, body, header = @client.get(uri, headers)
      return!(code, body)
    end

    def post(uri, payload, headers = CouchRest.default_headers)
      code, body, header = @client.post(uri, payload, headers)
      return!(code, body)
    end

    def delete(uri, headers = CouchRest.default_headers)
      code, body, header = @client.delete(uri, headers)
      return!(code, body)
    end

    def copy(uri, headers = CouchRest.default_headers)
      code, body, header = @client.copy(uri, headers)
      return!(code, body)
    end

  private
    def return! code, body
      if (200..207).include? code
        return body
      elsif Exceptions::EXCEPTIONS_MAP[code]
        raise Exceptions::EXCEPTIONS_MAP[code], [code, body]
      else
        raise RequestFailed, [code, body]
      end
    end
  end
end
