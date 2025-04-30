class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true

  scope :ordered_by_name, -> { order(:name) }
end
