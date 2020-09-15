class MedSearchResult
  attr_reader :brand_name, :product_ndc

  def initialize(brand_name, product_ndc)
    @brand_name = brand_name #med_data[:brand_name]
    @product_ndc = product_ndc #med_data[:product_ndc]
  end
end
