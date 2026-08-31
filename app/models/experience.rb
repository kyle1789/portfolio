class Experience < ApplicationRecord
  has_many_attached :screenshots
  validates :title, presence: true
  scope :ordered, -> { order(:position, :id) }

  def technology_list = technologies.to_s.split(",").map(&:strip).reject(&:blank?)
end
