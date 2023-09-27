require 'swagger_helper'

RSpec.describe 'auth/authentication', type: :request do
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
                                   location: 'Niger', price: 25, image: 'https://img.freepik.com/free-photo/blue-house-with-blue-roof-sky-background_1340-25953.jpg?size=626&ext=jpg')
    end
    @auth_headers = @user.create_new_auth_token if @user
  end

  path '/auth/sign_in' do
    post('Log in') do
      produces 'application/json'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        }
      }

      response(200, 'successful') do
        header 'access-token', schema: { type: :string, nullable: false },
                               description: "This serves as the user's password for each request. A hashed version of this value is stored in the database for later comparison. This value should be changed on each request."
        header 'client', schema: { type: :string, nullable: false },
                         description: 'This enables the use of multiple simultaneous sessions on different clients. (For example, a user may want to be authenticated on both their phone and their laptop at the same time.)'
        header 'expiry', schema: { type: :string, nullable: false },
                         description: 'The date at which the current session will expire. This can be used by clients to invalidate expired tokens without the need for an API request.'
        header 'uid', schema: { type: :string, nullable: false },
                      description: 'A unique value that is used to identify the user. This is necessary because searching the DB for users by their access token will make the API susceptible to timing attacks.'
        let(:user) do
          {
            email: 'yash@email.com',
            password: 'abcdef'
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

      response(401, 'incorrect password') do
        let(:user) do
          {
            email: 'yash@email.com',
            password: 'abcde'
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
    end
  end

  path '/auth/sign_up' do
    post('Create acount') do
      produces 'application/json'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          username: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        }
      }

      response(307, 'successful') do
        let(:user) do
          {
            email: 'nour@email.com',
            username: 'Nouridine',
            password: 'abcdef',
            password_confirmation: 'abcdef'
          }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end
    end
  end

  path '/auth/validate_token' do
    parameter name: 'access-token', in: :header, type: :string, required: true
    parameter name: 'client', in: :header, type: :string, required: true
    parameter name: 'uid', in: :header, type: :string, required: true
    get('Get the current use') do
      produces 'application/json'

      response(200, 'successful get the user') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }
        header 'access-token', schema: { type: :string, nullable: false },
                               description: "This serves as the user's password for each request. A hashed version of this value is stored in the database for later comparison. This value should be changed on each request."
        header 'client', schema: { type: :string, nullable: false },
                         description: 'This enables the use of multiple simultaneous sessions on different clients. (For example, a user may want to be authenticated on both their phone and their laptop at the same time.)'
        header 'expiry', schema: { type: :string, nullable: false },
                         description: 'The date at which the current session will expire. This can be used by clients to invalidate expired tokens without the need for an API request.'
        header 'uid', schema: { type: :string, nullable: false },
                      description: 'A unique value that is used to identify the user. This is necessary because searching the DB for users by their access token will make the API susceptible to timing attacks.'

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end

      response(401, 'Un authorized when the correct headers are not provided') do
        let(:'access-token') { 'access-token' }
        let(:client) { 'client' }
        let(:uid) { 'uid' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end
    end
  end

  path '/auth/sign_out' do
    parameter name: 'access-token', in: :header, type: :string, required: true
    parameter name: 'client', in: :header, type: :string, required: true
    parameter name: 'uid', in: :header, type: :string, required: true
    delete('Disconnect the user') do
      produces 'application/json'

      response(200, 'User successfully disconnected') do
        let(:'access-token') { @auth_headers['access-token'] }
        let(:client) { @auth_headers['client'] }
        let(:uid) { @auth_headers['uid'] }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: response.body
            }
          }
        end
        run_test!
      end
    end
  end
end
