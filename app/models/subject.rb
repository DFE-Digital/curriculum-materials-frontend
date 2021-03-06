class Subject < ApplicationRecord
  validates :name, presence: true, length: { maximum: 64 }, uniqueness: true

  has_many :complete_curriculum_programmes, dependent: :destroy
end
