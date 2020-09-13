class MsetService

  def med_search(params)
    conn.get('/med_search') do |req|
      req.params[:medication_name] = params
    end
  end

  # TEST CALLS
  def test_params(name)
    conn.get('/test2') do |req|
      req.params[:med_name] = 'adderall'
    end
  end

  def test(uri)
    conn.get(uri)
  end

  private

  def conn
    Faraday.new(ENV['MSET_API_SERVICE_DOMAIN'])
  end
end
