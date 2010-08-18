module RestAPI

  def default_headers
    {
      'content-type' => 'application/json',
      'accept'       => 'application/json'
    }
  end

  def http_client
    CouchRest.http_client
  end

  def put(uri, doc = nil, headers = default_headers)
    payload = doc.to_json if doc
    begin
      JSON.parse(http_client.put(uri, payload, headers))
    rescue Exception => e
      if $DEBUG
        raise "Error while sending a PUT request #{uri}\npayload: #{payload.inspect}\n#{e}"
      else
        raise e
      end
    end
  end

  def get(uri, headers = default_headers)
    begin
      JSON.parse(http_client.get(uri, headers), :max_nesting => false)
    rescue => e
      if $DEBUG
        raise "Error while sending a GET request #{uri}\n: #{e}"
      else
        raise e
      end
    end
  end

  def post(uri, doc = nil, headers = default_headers)
    payload = doc.to_json if doc
    begin
      JSON.parse(http_client.post(uri, payload, headers))
    rescue Exception => e
      if $DEBUG
        raise "Error while sending a POST request #{uri}\npayload: #{payload.inspect}\n#{e}"
      else
        raise e
      end
    end
  end

  def delete(uri, headers = default_headers)
    JSON.parse(http_client.delete(uri, headers))
  end

  def copy(uri, destination) 
    JSON.parse(http_client.copy(uri, default_headers.merge('Destination' => destination)))
  end

end
