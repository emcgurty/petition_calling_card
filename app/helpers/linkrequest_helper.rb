module LinkrequestHelper

  def remaining_resource_rows
    html = '' 
    if session[:remaining_resource_rows].nil?
      session[:remaining_resource_rows] = session[:resource_rows]
    end

    # Don't display the button if the max number of resources has been met
    if session[:remaining_resource_rows].to_i > 0
      html << submit_tag('Add New Resource',  {:class => 'button_style'})
    end
    html
  end
end
