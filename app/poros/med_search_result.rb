class MedSearchResult
  attr_reader :brand_name, :product_ndc

  def initialize(med_data)
    @brand_name = med_data[:brand_name]
    @product_ndc = med_data[:product_ndc]
  end
end
