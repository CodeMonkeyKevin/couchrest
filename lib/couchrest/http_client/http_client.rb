module CouchRest
  class HttpClient
    attr_accessor :client, :username, :password

    def initialize
      @client = Curl::Easy.new
      @client.http_auth_types = :basic
      @client.proxy_url = CouchRest.proxy_url
      @client
    end

    def put(uri, payload, headers = CouchRest.default_headers)
      @client.url = uri
      @client.headers = headers
      @client.http_put(payload.to_s)
      return!(@client.response_code, @client.body_str)
    end

    def get(uri, headers = CouchRest.default_headers)
      @client.url = uri
      @client.headers = headers
      @client.http_get
      return!(@client.response_code, @client.body_str)
    end

    def post(uri, payload, headers = CouchRest.default_headers)
      @client.url = uri
      @client.headers = headers
      @client.http_post(payload.to_s)
      return!(@client.response_code, @client.body_str)
    end

    def delete(uri, headers = CouchRest.default_headers)
      @client.url = uri
      @client.headers = headers
      @client.http_delete
      return!(@client.response_code, @client.body_str)
    end

    # TODO: add copy method to curb
    # def copy(uri, destination) 
      #
    # end

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