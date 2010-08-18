begin
  require 'curb'
rescue Exception => e
  
end

module HttpAdapter
  class Curb
    attr_accessor :client

    def initialize(proxyurl = nil)
      @client = Curl::Easy.new
      @client.http_auth_types = :basic
      @client.proxy_url = proxyurl
    end

    def proxy_url
      @client.proxy_url
    end

    def put(uri, payload, headers)
      @client.url = uri
      @client.headers = headers
      @client.http_put(payload.to_s)
      return @client.response_code, @client.body_str, @client.headers
    end

    def get(uri, headers)
      @client.url = uri
      @client.headers = headers
      @client.http_get
      return @client.response_code, @client.body_str, @client.headers
    end

    def post(uri, payload, headers)
      @client.url = uri
      @client.headers = headers
      @client.http_post(payload.to_s)
      return @client.response_code, @client.body_str, @client.headers
    end

    def delete(uri, headers)
      @client.url = uri
      @client.headers = headers
      @client.http_delete
      return @client.response_code, @client.body_str, @client.headers
    end

    def copy(uri, headers)
      @client.url = uri
      @client.headers = headers
      @client.http('COPY')
      return @client.response_code, @client.body_str, @client.headers
    end

  end
end
