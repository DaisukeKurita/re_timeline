module DeviseHelper
  def devise_bootstrap_alert(key)
    case key
    when "alert"
      "warning"
    when "notice"
      "success"
    when "error"
      "danger"
    else
      key.to_s
    end
  end
end
