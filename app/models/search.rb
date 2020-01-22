class Search < ApplicationRecord
  has_and_belongs_to_many :movies, dependent: :destroy

  validates :query, presence: true, allow_blank: false

  def self.by_query(query_str)
    existing_search = where("lower(query) = ?", query_str.downcase).first
    return existing_search if existing_search && existing_search.current?

    self.new(query: query_str)
  end

  def current?
    created_at >= 24.hours.ago
  end

  def as_json
    movies.collect &:as_json
  end
end