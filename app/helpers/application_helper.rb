module ApplicationHelper

  def highlight_state(obj)
    content_tag :span, t(obj.class.name.downcase + '.' + obj.state), class: "state #{obj.state}-state"
  end

  def link_to_s(body, url, controller, action = false)
    link_to body, url, class: is_selected(controller, action)
  end

  def number_to_price(num)
    num = 0 if num.nil?
    content_tag(:span, number_to_currency(num),:class => "c-#{price_to_color(num)}")
  end


private

  def is_selected(controller, action = false)
    'selected' if params['controller'] == controller and (!action or params['action'] == action)
  end

end
