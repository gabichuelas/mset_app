class SearchResultsFacade
  def initialize
    @service ||= MsetService.new
  end

  def med_search_results(name)
    response = @service.med_search(name)
    results = json_parse(response)[:results]
    return nil if results.nil?
    create_medsearchresult_objects(results)
  end

  def save_symptoms(med_id)
    medication = Medication.find(med_id)
    symptoms = extract_symptoms(medication.product_ndc)
    if !symptoms.nil?
      symptoms.each do |symptom|
        new_sym = Symptom.find_or_create_by(description: symptom)
        MedicationSymptom.create(medication_id: med_id, symptom_id: new_sym.id)
      end
    end
  end

  private

  def extract_symptoms(product_ndc)
    tables = adverse_reactions_table(product_ndc)
    return nil if tables.nil? || tables[0].nil?
    symptoms = []
    tables.each do |table|
      table.each do |t|
        nokogiri_parser(t, symptoms)
      end
    end
    symptoms.uniq!
    symptoms.delete("") if symptoms.include?("")
    symptoms
  end

  def adverse_reactions_table(product_ndc)
    response = @service.sym_search(product_ndc)
    results = json_parse(response)[:results]
    return nil if results.nil?
    results.map do |result|
      result[:adverse_reactions_table]
    end
  end

  def nokogiri_parser(table, acc)
    page = Nokogiri::XML(table)
    page.css('tbody').select do |node|
      node.traverse do |el|
        acc << el.text.strip unless el.text.include?('%') || el.text.include?('System') || el.text.strip == 'General' || el.text.strip == 'Metabolic/Nutritional' || el.name == 'footnote' || el.text == ' ' || el.text.split(' ').size > 3 || el.text.include?('only') || el.text=~ /\d/
      end
    end
  end

  def create_medsearchresult_objects(results)
    med_hash = Hash.new(0)
    results.each do |result|
      if med_hash.keys.include?(result[:brand_name])
        next
      else
        med_hash[result[:brand_name]] = result[:product_ndc]
      end
    end

    med_hash.map do |brand_name, product_ndc|
      MedSearchResult.new(brand_name, product_ndc)
    end
  end

  def json_parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
