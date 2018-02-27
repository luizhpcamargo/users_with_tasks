require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { User.create(email: 'test@email.com', password: 'test', password_confirmation: 'test') }

  it '#index' do
    get :index
    expect(response).to render_template(:index)
  end

  context '#signin' do
    it do
      expect(user.valid?).to be_truthy
      post :signin, params: { user: { email: 'test@email.com', password: 'test' } }
      expect(response).to render_template('tasks/index')
    end

    it do
      post :signin, params: {user: { email: 'notexists@email.com', password: 'test' } }
      expect(response).to render_template(:index)
    end
  end

  context '#create' do
    it do
     expect {
       post :create, params: {user: {email: 'test2@email.com', password: 'test', password_confirmation: 'test'}}
     }.to change{ User.count }.by(1)
    end
  end
end
