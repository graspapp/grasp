# http://stackoverflow.com/questions/10800658/how-to-put-modals-in-partials
module ModalHelper
  def modal(css_id, hidden = true, &block)
    content_tag(:div, class: "reveal-modal", id: css_id,
                "data-reveal" => true) do
      yield
    end
  end

  def modal_link(link_text, href, options = {})
    options.merge!({ "data-reveal-id" => href })
    link_to link_text, "#", options
  end
end
