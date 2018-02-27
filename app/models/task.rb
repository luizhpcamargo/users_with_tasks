class Task < ApplicationRecord
  belongs_to :user

  validates_presence_of :description
  validate :valid_schedule?

  protected

  def valid_schedule?
    return if start_date.nil? || end_date.nil?
    errors.add(:schedule, "is not valid") if start_date > end_date
  end
end
