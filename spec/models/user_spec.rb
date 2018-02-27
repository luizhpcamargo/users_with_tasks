require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(have_many(:tasks)).to be_truthy }

  describe '#password' do
    let (:user) {User.new(password: 'initial_password', password_confirmation: 'initial_password')}
    it { expect(user.password_digest.present?).to be_truthy}
    it { expect(user.password_digest).to_not be 'initial_password' }
  end
end
