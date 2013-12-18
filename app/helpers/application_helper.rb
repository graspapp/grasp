module ApplicationHelper
  def full_title(page_title)
    base_title = "Grasp"
    page_title.empty? ? base_title : "#{ page_title } | #{ base_title }"
  end

  def my_devise_error_messages!
    return "" if resource.errors.empty? && resource.role.errors.empty?

    messages = role_messages = ""

    if !resource.errors.empty?
      messages = resource.errors.full_messages.map { |msg|
        content_tag(:li, msg)
      }.join
    end

    if !resource.role.errors.empty?
      role_messages = resource.role.errors.full_messages.map { |msg|
        content_tag(:li, msg)
      }.join
    end

    messages = messages + role_messages   
    sentence = I18n.t("errors.messages.not_saved",
                      count: resource.errors.count +
                        resource.role.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
    <h2>#{sentence}</h2>
    <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end
end
