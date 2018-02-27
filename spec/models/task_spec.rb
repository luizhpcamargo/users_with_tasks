require 'rails_helper'

RSpec.describe Task, type: :model do
  let (:task) { Task.new(user: User.new) }
  it { expect(task.build_user).to be_a(User) }

  context 'description' do
    before do
      task.description = nil
      task.valid?
    end
    it { expect(task.valid?).to be_falsey }
    it { expect(task.errors[:description]).to include 'can\'t be blank' }
  end

  context '#valid_schedule?' do
    before do
      task.description = 'I\'m a test'
    end
    context 'invalid schedule' do
      before do
        task.start_date = 1.day.ago
        task.end_date = 2.days.ago
        task.valid?
      end

      it { expect(task.valid?).to be_falsey }
      it { expect(task.errors[:schedule]).to include 'is not valid' }
    end

    context 'with no schedule' do
      before do
        task.start_date = nil
        task.end_date = nil
      end

      it { expect{task.valid?}.to_not raise_error }
    end

    context 'valid schedule' do
      before do
        task.start_date = 2.days.ago
        task.end_date = 2.days.since
        task.valid?
      end

      it { expect(task.valid?).to be_truthy }
    end
  end


end
