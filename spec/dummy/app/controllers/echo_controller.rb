class EchoController < ApplicationController
  def show
    render text: params[:text]
  end
end
