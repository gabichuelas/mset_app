RSpec.describe 'sinatra connection' do
  before :each do
    @service = MsetService.new
  end

  it 'can connect to mset_service_app in sinatra' do
    answer = @service.test('/test')

    expect(answer.status).to eq(200)
    expect(answer.body).to eq("Hello World")
  end

  it 'can send a param' do
    answer = @service.test_params('adderall')

    expect(answer.status).to eq(200)
    expect(answer.body).to eq('adderall')
  end
end
