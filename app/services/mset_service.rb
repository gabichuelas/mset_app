class MsetService

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
    # run $ rackup from mset_service_app
    # directory for this connection to work.
    Faraday.new('http://localhost:9292')
  end

end
