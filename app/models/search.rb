class Search < ApplicationRecord
  has_and_belongs_to_many :movies, dependent: :destroy

  validates :query, presence: true, uniqueness: true, allow_blank: false

  def self.by_query(query_str)
    where("lower(query) = ?", query_str.downcase).first || self.new(query: query_str)
  end

  def as_json
    movies.collect &:as_json
  end
end