require 'spec_helper'

describe 'GET /experiences' do
  it 'returns an empty array when there are no experiences' do
    get '/experiences.json'

    expect(response.body).to eq('[]')
  end

  it 'returns an array of experience objects when there are experiences in the DB' do
    FactoryGirl.create(:experience, tagline: 'Walk down Lombard street')
    FactoryGirl.create(:experience, tagline: "Eat a clam chowder bread bowl at Alito's")
    FactoryGirl.create(:experience, tagline: 'Hang out in Golden Gate park')

    get '/experiences.json'

    expected_response = [
      { id: 1, tagline: 'Walk down Lombard street' },
      { id: 2, tagline: "Eat a clam chowder bread bowl at Alito's" },
      { id: 3, tagline: 'Hang out in Golden Gate park' }
    ]

    actual_response = JSON.parse(response.body).map(&:symbolize_keys!)
    expect(actual_response).to eq(expected_response)
  end
end

describe 'POST /experiences' do
  it 'creates a new experience in the DB' do
    post '/experiences.json', tagline: 'Do something brand new!'

    expect(response.body).to eq({ id: 1, tagline: 'Do something brand new!' }.to_json)
    expect(Experience.count).to eq(1)
  end
end

describe 'DELETE /experiences/:id' do
  it 'destroys the specified experience' do
    experience = FactoryGirl.create(:experience)
    delete "/experiences/#{experience.id}.json"
    expect(Experience.count).to eq(0)
    expect(response.status).to eq(204)
  end
end
