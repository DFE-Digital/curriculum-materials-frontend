class Lesson < ApplicationRecord
  validates :unit_id, presence: true

  validates :name,
            presence: true,
            length: { maximum: 256 }

  validates :summary, presence: true

  belongs_to :unit
end