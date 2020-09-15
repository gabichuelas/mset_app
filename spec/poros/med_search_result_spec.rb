RSpec.describe MedSearchResult do
  it 'has attributes' do
    brand_name = "Adderall"
    product_ndc = "123-1234"

    adderall = MedSearchResult.new(brand_name, product_ndc)

    expect(adderall).to be_an_instance_of(MedSearchResult)
    expect(adderall.brand_name).to eq("Adderall")
    expect(adderall.product_ndc).to eq("123-1234")
  end
end
