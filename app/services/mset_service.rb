class MsetService
  
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
