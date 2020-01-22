class Movie < ApplicationRecord
  belongs_to :search

  validates :search, presence: true

  def title
    search.query.titlecase
  end

  def as_json
    {
      title: title,
      description: description
    }
  end
end