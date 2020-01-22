class Api::V1::SearchesController < Api::BaseController
  before_action :validate_params, only: :index

  def index
    @search = Search.by_query(params[:query])

    render json: @search.as_json
  end

  private

  def validate_params
    raise Api::Exceptions::BadRequest unless params[:query]&.present?
  end
end
