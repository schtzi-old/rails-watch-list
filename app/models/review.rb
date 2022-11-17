class Review < ApplicationRecord
  belongs_to :list

  validates :content, presence: true
  validates :rating, presence: true

  validates :rating, numericality: { only_integer: true, in: (0..5) }
end
