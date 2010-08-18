require 'rest_client'

module HttpAdapter
  class Restclient

    def initialize(proxyurl = nil)
      @client = RestClient
      @client.proxy = proxyurl
    end

    def proxy_url
      @client.proxy
    end

    def put(uri, payload, headers)
      response = @client::Request.mod_execute(:method => :put, :url => uri, :payload => payload, :headers => headers)
      return response.code, response.body, response.headers
    end

    def get(uri, headers)
      response = @client::Request.mod_execute(:method => :get, :url => uri, :headers => headers)
      return response.code, response.body, response.headers
    end

    def post(uri, payload, headers)
      response = @client::Request.mod_execute(:method => :post, :url => uri, :payload => payload, :headers => headers)
      return response.code, response.body, response.headers
    end

    def delete(uri, headers)
      response = @client::Request.mod_execute(:method => :delete, :url => uri, :headers => headers)
      return response.code, response.body, response.headers
    end

    def copy(uri, headers)
      response = @client::Request.mod_execute(:method => :copy, :url => uri, :headers => headers)
      return response.code, response.body, response.headers
    end

  end
end
