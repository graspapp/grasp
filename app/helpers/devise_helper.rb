module DeviseHelper
  def devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map do |msg|
      content_tag(:li, msg)
    end.join

    sentence = I18n.t('errors.messages.not_saved',
                      count: resource.errors.count,
                      resource: resource.class.model_name.human.downcase)

    html = error_html(sentence, messages)
    html.html_safe
  end

  private

  def error_html(sentence, messages)
    <<-HTML
       <div class="alert alert-danger"> <button type="button"
        class="close" data-dismiss="alert">x</button>
        <h4>#{ sentence }</h4>
        #{ messages }
       </div>
    HTML
  end
end
