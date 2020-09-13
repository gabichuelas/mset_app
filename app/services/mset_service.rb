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
    # Faraday.new('http://localhost:9292')

    # using mset_service_app on heroku:
    # will only work once mset_service is updated on heroku with latest PR.
    Faraday.new(ENV['MSET_API_SERVICE_DOMAIN'])
  end

end
