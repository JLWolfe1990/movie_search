class Api::BaseController < ApplicationController
  rescue_from Api::Exceptions::BadRequest do
    render json: [], status: :bad_request
  end
end