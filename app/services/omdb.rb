class Services
  class Omdb
    API_KEY = ENV["OMDB_API_KEY"].freeze

    def initialize(search)
      @search = search
    end

    def perform
      search_results.each do |movie_json|
        @search.movies << Movie.find_or_create_by!(title: movie_json["Title"])
      end
    end

    private

    def search_results
      JSON.parse(response.body)["Search"]
    end

    def response
      HTTParty.get(url + params)
    end

    def url
      ENV["OMDB_API_URL"] + '?apiKey=' + ENV["OMDB_API_KEY"] + '&'
    end

    def params
      { s: @search.query, type: 'movie' }.to_query
    end
  end
end
