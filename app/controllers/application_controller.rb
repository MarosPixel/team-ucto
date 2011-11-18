class ApplicationController < ActionController::Base
  protect_from_forgery

  # rescue_from CanCan::AccessDenied do |exception|
  #   flash[:error] = "Access denied."
  #   redirect_to root_url
  # end

  protected

    # override for each controller
    def tracked_object
    end

    # Yes that is right, on save changes resets. I'd say the best way 
    # to do this (and I did this sort of thing before) is to put 
    # the logic in the model in either a callback or an observer, 
    # and pass the action name along. In such a context (callback or observer) 
    # the changes hash is not yet reset.
    def action_tracking
      tracked_object.logs.create(creator_id: current_user.try(:id), 
                                 action: params[:action])
      # tracked_object.logs.create(creator_id: current_user.try(:id), 
      #                            action: params[:action], 
      #                            comment: tracked_object.changes.to_s)
    end
  
end
