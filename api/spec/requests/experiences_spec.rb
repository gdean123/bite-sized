require 'spec_helper'

describe '/experiences' do
  describe 'GET index' do
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
end
