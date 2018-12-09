# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users/:id' do
    it 'returns status 404' do
      get user_path(User.last.id + 1)
      expect(response).to have_http_status(404)
    end
  end

  let!(:user) { FactoryBot.create(:user) }
  let!(:user_2) { FactoryBot.create(:user) }

  describe 'GET /users' do
    it 'returns status 200' do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users' do
    it 'returns list of users' do
      get users_path
      expect(JSON.parse(response.body)['data'][0]['attributes']).to include_json(email: user.email,
                                                                                 name: user.name)
      expect(JSON.parse(response.body)['data'][1]['attributes']).to include_json(email: user_2.email,
                                                                                 name: user_2.name)
    end
  end

  describe 'GET /users/:id' do
    it 'returns status 200' do
      get user_path(User.last.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:id' do
    it 'returns email and name for user' do
      get user_path(user.id)
      expect(JSON.parse(response.body)['data']['attributes']).to include_json(email: user.email,
                                                                              name: user.name)
    end
  end

  describe 'POST /users' do
    it 'returns status 201' do
      post '/users', params: { user: { email: Faker::Internet.email,
                                       password: 'password',
                                       name: Faker::Name.name } }
      expect(response).to have_http_status(201)
    end
  end

  describe 'POST /users' do
    it 'create new user and returns his id' do
      post '/users', params: { user: { email: Faker::Internet.email,
                                       password: 'password',
                                       name: Faker::Name.name } }
      expect(JSON.parse(response.body)['data']).to include_json(id: User.last.id)
    end
  end

  describe 'POST /users' do
    it 're-creating a new user with not unique email returns status 422' do
      post '/users', params: { user: { email: 'example@mail.ru',
                                       password: 'password',
                                       name: 'John' } }
      post '/users', params: { user: { email: 'example@mail.ru',
                                       password: 'password',
                                       name: 'John' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'POST /users' do
    it 'an attempt to create a new user with empty email returns status 422' do
      post '/users', params: { user: { email: '',
                                       password: 'password',
                                       name: 'John' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'POST /users' do
    it 'an attempt to create a new user with empty password returns status 422' do
      post '/users', params: { user: { email: 'user1@mail.ru',
                                       password: '',
                                       name: 'John' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'POST /users' do
    it 'an attempt to create a new user with empty name returns status 422' do
      post '/users', params: { user: { email: 'user2@mail.ru',
                                       password: 'password',
                                       name: '' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'POST /users' do
    it 'an attempt to create a new user with very long name returns status 422' do
      post '/users', params: { user: { email: 'user3@mail.ru',
                                       password: 'password',
                                       name: 'Johnoooooooooooooooooooooooooooooooooooooo
                                      ooooooooooooooooooooooooooooooooooooo' } }
      expect(response).to have_http_status(422)
    end
  end
end
