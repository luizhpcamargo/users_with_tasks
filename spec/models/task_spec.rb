require 'rails_helper'

RSpec.describe Task, type: :model do
  let (:task) { Task.new }
  it { expect(task.build_user).to be_a(User) }
end
