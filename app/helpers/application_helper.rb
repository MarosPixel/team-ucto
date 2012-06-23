module ApplicationHelper

  public

    def link_to_s(body, url, controller, action = false)
      link_to body, url, class: is_selected(controller, action)
    end

  private

    def is_selected(controller, action = false)
      'selected' if params['controller'] == controller and (!action or params['action'] == action)
    end

end
