RSpec.describe 'sinatra connection' do
  it 'can connect to mset_service_app in sinatra' do
    service = MsetService.new
    answer = service.test('/test')

    expect(answer.status).to eq(200)
    expect(answer.body).to eq("Hello World")
  end
end
