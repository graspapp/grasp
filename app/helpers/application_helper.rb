module ApplicationHelper
  def full_title(page_title)
    base_title = "Grasp"
    page_title.empty? ? base_title : "#{ page_title } | #{ base_title }"
  end
  
  def convert_mastery?(mastery)
    if mastery == -1
      "NY"
    elsif mastery == 0
      "N"
    else
      mastery
    end
  end
end
