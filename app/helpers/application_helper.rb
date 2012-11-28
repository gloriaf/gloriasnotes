module ApplicationHelper
 
  # Devuelve el titulo completo
  def full_title (page_title)
    base_title = "Gloria's Notes"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
  
end
