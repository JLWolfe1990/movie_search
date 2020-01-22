class Movie < ApplicationRecord
  has_and_belongs_to_many :searches, dependent: :destroy

  validates :title, presence: true

  def as_json
    {
      title: title.titlecase
    }
  end
end