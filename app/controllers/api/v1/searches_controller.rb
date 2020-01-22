class Api::V1::SearchesController < Api::BaseController
  before_action :validate_params, only: :index

  def index
    begin
      @search = Search.by_query(params[:query])
      if(@search.new_record?)
        Services::Omdb.new(@search.tap(&:save)).perform
      end

      render json: @search.as_json
    rescue Services::Omdb::Error => e
      Rails.logger.error("[Api::V1::SearchesController] OMDb threw error '#{e.message}'")
      render json: [], status: :not_acceptable
    end
  end

  private

  def validate_params
    raise Api::Exceptions::BadRequest unless params[:query]&.present?
  end
end
