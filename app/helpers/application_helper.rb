module ApplicationHelper
  
  public

    def link_to_s(body, url, controller, action = 'index')
      link_to body, url, class: is_selected(controller, action)
    end

  private

    def is_selected(controller, action = 'index')
      'selected' if params['controller'] == controller and params['action'] == action
    end

end
