module ApplicationHelper
  
  public

    def link_to_s(body, url, controller)
      link_to body, url, class: is_selected(controller)
    end

  private

    def is_selected(controller)
      'selected' if params['controller'] == controller
    end

end
