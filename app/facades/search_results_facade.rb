class SearchResultsFacade
  def initialize
    @service ||= MsetService.new
  end

  def med_search_results(name)
    response = @service.med_search(name)
    results = json_parse(response)[:results]
    return nil if results.nil?
    med_and_ndc_hash(results)
  end

  private

  def med_and_ndc_hash(results)
    # should this return a temporary_medication PORO
    # instead of a hash...?
    med_hash = Hash.new(0)
    results.each do |result|
      if med_hash.keys.include?(result[:brand_name])
        next
      else
        med_hash[result[:brand_name]] = result[:product_ndc]
      end
    end
    med_hash
  end

  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
