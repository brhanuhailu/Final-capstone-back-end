require 'swagger_helper'

RSpec.describe 'api/v1/houses', type: :request do
  before do
    @user = User.find_by(username: 'test')
    if @user.nil?
      @user = User.create(
        username: 'Yashodhi',
        email: 'yash@email.com',
        password: 'abcdef',
        password_confirmation: 'abcdef'
      )
      @house = @user.houses.create(name: 'House1', description: 'beautiful house', area: 100, number_of_rooms: 3,
                                   location: 'Niger', price: 25)
    end

    @auth_headers = @user.create_new_auth_token if @user
  end

  path '/api/v1/houses' do
    parameter name: 'access-token', in: :header, type: :string, required: true
    parameter name: 'client', in: :header, type: :string, required: true
    parameter name: 'uid', in: :header, type: :string, required: true

    get('list houses') do
      produces 'application/json'
      consumes 'application/json'
      response(200, 'successful') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }

        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   user_id: { type: :integer },
                   name: { type: :string },
                   description: { type: :string },
                   location: { type: :string },
                   created_at: { type: :string },
                   updated_at: { type: :string },
                   area: { type: :integer },
                   number_of_rooms: { type: :integer },
                   price: { type: :string }
                 }
               }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
      response(401, 'Unauthorized') do
        let(:'access-token') { 'access-token' }
        let(:client) { 'client' }
        let(:uid) { 'uid' }

        schema type: :object,
               properties: {
                 errors: {
                   type: :array,
                   items: { type: :string }
                 }
               }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    post('create house') do
      produces 'application/json'
      consumes 'application/json'
      # parameter name: 'access-token', in: :header, type: :string, required: true
      # parameter name: 'client', in: :header, type: :string, required: true
      # parameter name: 'uid', in: :header, type: :string, required: true

      parameter name: :house, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          area: { type: :number },
          price: { type: :number },
          description: { type: :string },
          number_of_rooms: { type: :number },
          location: { type: :string }
        }
      }

      response(201, 'successful') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }
        let(:house) do
          {
            name: 'House2',
            area: 4,
            price: 200,
            description: 'Nice house',
            number_of_rooms: 4,
            location: 'Nowhere'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'Unprocessable entity(when a required parameter is missing)') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }
        let(:house) do
          {
            price: 200,
            description: 'Nice house',
            number_of_rooms: 4
          }
        end

        schema type: :object,
               properties: {
                 errors: {
                   type: :array,
                   items: { type: :string }
                 }
               }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/houses/{id}' do
    # You'll want to customize the parameter types...

    get('show house') do
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: 'id', in: :path, type: :number, description: 'id'

      response(200, 'successful') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }
        let(:id) { @house.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete house') do
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: 'id', in: :path, type: :number, description: 'id'
      response(200, 'successful') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }
        let(:id) { @house.id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
