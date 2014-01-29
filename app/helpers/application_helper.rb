module ApplicationHelper
  def full_title(page_title)
    base_title = "Grasp"
    page_title.empty? ? base_title : "#{ page_title } | #{ base_title }"
  end
  
  def yes_or_no(completed)
    completed ? "Yes" : "No"
  end
  
  def negative_mastery?(mastery)
    if mastery == -1
      "NY"
    else
      mastery
    end
  end
end
