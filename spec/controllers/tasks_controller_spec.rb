require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let(:user) { User.create(email: 'test@email.com', password: 'test', password_confirmation: 'test') }
  before do
    session[:user_id] = user.id
  end

  it '#index' do
    get :index, params: { user_id: user.id }
    expect(response).to render_template(:index)
  end

  context '#create' do
    it do
      expect {
        post :create, params: {
          user_id: user.id,
          task: {
            start_date: 1.day.ago,
            end_date: 1.day.since,
            description: 'test'
          }}
      }.to change{ Task.count }.by(1)
    end
  end
end
