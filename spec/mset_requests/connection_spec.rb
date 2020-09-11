RSpec.describe 'can connect to mset_service_app in sinatra' do

  service = MsetService.new
  service.search_meds('/v1/med_search')

  expect(response).to have_http_status(:success)
  expect(response.body).to have_content("Hello World")
end
