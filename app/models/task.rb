class Task < ApplicationRecord
  belongs_to :project, counter_cache: true
  belongs_to :parent, class_name: "Task", optional: true
  has_many :subtasks, class_name: "Task", foreign_key: "parent_id", dependent: :destroy

  attribute :expires_at, :datetime, default: -> { 6.months.from_now }

  scope :active, -> { where("expires_at > ?", Time.current) }
  scope :expired, -> { where("expires_at <= ?", Time.current) }
  scope :root_tasks, -> { where(parent_id: nil) }
end
