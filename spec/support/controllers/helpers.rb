module Controller
  module Helpers
    def response_json
      JSON.parse(response.body)
    end
  end
end
