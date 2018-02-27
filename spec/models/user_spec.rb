require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(have_many(:tasks)).to be_truthy }

  context '#password' do
    let (:user) {User.new(password: 'initial_password', password_confirmation: 'initial_password')}
    it { expect(user.password_digest.present?).to be_truthy}
    it { expect(user.password_digest).to_not be 'initial_password' }
  end

  context 'password presence' do
    let(:user) { User.new(email: 'test@valid.com') }

    it do
      expect(user.valid?).to be_falsey
      expect(user.errors[:password]).to include 'can\'t be blank'
    end

    it do
      user.password = 'test'
      expect(user.valid?).to be_truthy
    end
  end

  context 'email validation' do
    let(:valid_email) { User.new(email: 'test@email.com', password: 'checking') }
    let(:invalid_email) { User.new(email: '@@test', password: 'checking') }

    it { expect(valid_email.valid?).to be_truthy }

    it do
      expect(invalid_email.valid?).to be_falsey
      expect(invalid_email.errors[:email]).to include 'is invalid'
    end

    it do
      valid_email.save
      user = valid_email.dup
      expect(user.valid?).to be_falsey
      expect(user.errors[:email]).to include 'has already been taken'
    end
  end
end
