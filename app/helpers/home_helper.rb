module HomeHelper
  def view_all_perspectives
    html = ''
    approved_perspectives = Perspectives.find(:all, :readonly=> true, :conditions => "approved = 1" )
    if (approved_perspectives.count  > 0)
      html << "<li class=tier2> #{link_to 'View All Perspectives', perspectives_show_url} </li>"
    else
      html <<  "<li class=tier2>View All Perspectives</li>"
    end
    html
  end

  def view_all_signatures
    html = ''
    if (Signatures.count  > 0)
      html <<  "<li class=tier2> #{link_to 'View All Signatures', show_refresh_url}</li>"
    else
      html <<  "<li class=tier2>View All Signatures</li>"
    end
    html
  end


end
