class MsetService

  def search_meds(uri)
    response = conn.get(uri)
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(ENV['MSET_SERVICE'])
  end
  
end
