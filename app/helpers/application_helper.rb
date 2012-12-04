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
  
  # Deveulve link para ordenar columnas de la tabla de topicos, orden asc o desc
  def sortable(column, title = nil)
    title ||= column.titleize
    icono_flecha = column == sort_column ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction, :topics_types => @selected_topic_types}, {:class => icono_flecha}
  end
  
end
