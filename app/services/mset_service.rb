class MsetService

  def sym_search(params)
    get('/sym_search', :product_ndc, params)
  end

  def med_search(params)
    get('/med_search', :medication_name, params)
  end

  private

  def get(uri, param_key, params)
    conn.get(uri) do |req|
      req.params[param_key] = params
    end
  end

  def conn
    # FOR TESTING WITH LOCAL SERVER
    Faraday.new('http://localhost:9292')

    # LIVE SINATRA CONNECTION
    # Faraday.new(ENV['MSET_API_SERVICE_DOMAIN'])
  end
end
