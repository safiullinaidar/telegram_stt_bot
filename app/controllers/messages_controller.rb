class MessagesController < ApplicationController
  def create
    params.permit!
    Messages::Create.call(params[:message])

    render json: { result: :ok }
  end
end
