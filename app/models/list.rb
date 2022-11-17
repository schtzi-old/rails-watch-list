class List < ApplicationRecord
  FILE_TYPES = %w[image/jpeg image/png].freeze
  MAX_FILE_SIZE = 10_000_000

  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
  has_one_attached :file, dependent: :destroy

  validates :name, presence: true
  validates :name, uniqueness: true

  validates :file, presence: true

  # validates :file, file_size: { less_than_or_equal_to: MAX_FILE_SIZE }, file_content_type: { allow: FILE_TYPES }

  validate :validate_file_filetypes
  validate :validate_file_filesize

  private

  def validate_file_filetypes
    return unless file.attached?

    errors.add(:file, 'must be a JPG or PNG') unless file.content_type.in?(FILE_TYPES)
  end

  def validate_file_filesize
    return unless file.attached?

    errors.add(:file, 'must be max. 10mb') unless file.blob.byte_size <= MAX_FILE_SIZE
  end
end
