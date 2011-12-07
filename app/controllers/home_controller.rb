class HomeController < ApplicationController
  authorize_resource class: false

  def index
    respond_to do |format|
      format.html # index.html.haml
    end
  end

end
