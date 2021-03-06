class FixedCost < ActiveRecord::Base
  belongs_to :round

  validates :name, presence: true
  validates :round_id, presence: true
  validates :amount, presence: true
end
