# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def generate_combo(name, selected)
    html = '<select name="'
    html << name.to_s
    html << '"><option value="">'
    html << 'Please select'
    html << "</option>\n"
    CollaboratorMethods.collaborator_value[name].each do |val|
      if val[0] == selected
        html << "<option value='#{val[0]}' selected='selected'>#{val[1]}</option>\n"
      else
        html << "<option value='#{val[0]}'>#{val[1]}</option>\n"
      end
    end
    html << "</select>\n"
    html
  end

  def find_element_in_multidimensional_array(this_array, sought_value)

    return_string = 'NA'
    this_array.each do |i_array|
      i_array.each_with_index do |in_array, i_index|
        if in_array ==  sought_value
          return_string = in_array[i_index][1]
        end
      end
    end
    return_string
  end

  def check_for_errors(data_source)

    html = ''
    if data_source.errors.any?

      html << '<div id="error_explanation" style="margin-left:15px;margin-top:10px;"><h2>'
      html  << pluralize(data_source.errors.count, "error")
      html << ' prohibited this new record from being saved:</h2><p>There were problems with the following fields: </p>'
      html << ' <ul>'
      data_source.errors.full_messages.each do |msg|
        html << '<li>'
        html <<    msg
        html << '</li>'
      end
      html << '</ul></div>'
    end
    html
  end

  def login_menu_options
    html = ''
    html << '<ul class=menu>'
    html << "<li>"
    html << link_to('Home',home_show_url)
    html << "</li>"
    @user_session = false
    @user_session = session[:user_id].nil?
    @any_user = Users.find(:all).count
    if (@any_user == 0)
      html << "<li>"
      html << link_to('Register', users_new_url)
      html << "</li>"
    elsif (@any_user >= 1) && (@user_session) 
      html << "<li>"
      html << link_to('Login', users_show_url)
      html << "</li>"
    elsif (@any_user >= 1)   && !(@user_session) 
      html << "<li>"
      html << link_to('Logout', users_logout_url )
      html << "</li>"
      html << "<li>"
      html << link_to('Update User Information', users_update_user_information_url(session[:user_id]) )
      html << "</li>"
    end
      html << "<li>"
      html << link_to('Approvals', :controller => 'admin', :action => 'tables_to_approve' )
      html << "</li>"
    html << "</ul>"
    html

  end

  def get_full_name(object)
    fullname = ''
    strmi = object.mi
    if strmi.blank?
      fullname = object.first_name + " " + object.last_name
    else
      fullname = object.first_name + " " + object.mi + " " + object.last_name
    end
    fullname
  end

  def get_organization_url(url)
    html = ''
    org_url = "http://" + url.to_s
    org_url1 = org_url.gsub('.', '(dot)' )
    html << "<a href='#{org_url}'>#{org_url1}</a>"
    html
  end
end
