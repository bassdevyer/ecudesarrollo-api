require 'rails_helper'

RSpec.describe 'Persons API', type: :request do
  # initialize test data
  let!(:persons) {create_list(:person, 10)}
  let(:person_id) {persons.first.id}

=begin
Todos:            GET /persona/
Buscar un id: GET /persona/{id}
Grabar:           POST /persona/
Eliminar:         DELETE /persona/{id}
=end

  # Test suite for GET /person
  describe 'GET /persons' do
    # make HTTP get request before each example
    before {get '/persons'}

    it 'returns persons' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /person/:id
  describe 'GET /persons/:id' do
    before {get "/persons/#{person_id}"}

    context 'when the record exists' do
      it 'returns the person' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(person_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:person_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Person/)
      end
    end
  end

  # Test suite for POST /person
  describe 'POST /persons' do
    # valid payload
    let(:dni) {Faker::IDNumber.valid}
    let(:valid_attributes) {{dni: dni, names: Faker::Name.first_name + Faker::Name.middle_name, surnames: Faker::Name.last_name + Faker::Name.last_name}}

    context 'when the request is valid' do
      before {post '/persons', params: valid_attributes}

      it 'creates a person' do
        expect(json['dni']).to eq(dni)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/persons', params: {dni: Faker::IDNumber.valid, names: Faker::Name.first_name + Faker::Name.middle_name}}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
            .to match(/Validation failed: Surnames can't be blank/)
      end
    end
  end

  # Test suite for PUT /person/:id
  describe 'PUT /persons/:id' do
    let(:valid_attributes) {{names: Faker::Name.first_name + Faker::Name.middle_name}}

    context 'when the record exists' do
      before {put "/persons/#{person_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /person/:id
  describe 'DELETE /persons/:id' do
    before {delete "/persons/#{person_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end