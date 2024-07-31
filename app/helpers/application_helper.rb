module ApplicationHelper
  def bootstrap_class_for_flash(type)
    case type
    when 'notice' then 'success'
    when 'alert' then 'danger'
    else type
    end
  end
end
