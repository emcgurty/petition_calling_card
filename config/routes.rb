ActionController::Routing::Routes.draw do |map|
  
  map.signatures_new 'signatures/new', :controller => "signatures", :action => "new"
  map.show_refresh 'signatures/show_refresh/:id', :controller => "signatures", :action => "show_refresh"
  map.perspectives_destroy 'perspectives/destroy/:id', :controller => "perspectives", :action => "destroy"
  map.perspectives_new 'perspectives/new', :controller => "perspectives", :action => "new"
  map.perspectives_accept 'perspectives/accept', :controller => "perspectives", :action => "accept"
  map.perspectives_show 'perspectives/show', :controller => "perspectives", :action => "show"
  map.comments_delete  'comments/delete/:id', :controller => "comments", :action => "delete"
  map.comments_new  'comments/new/:id', :controller => "comments", :action => "new"
  map.comments_list  'comments/list/:id', :controller => "comments", :action => "list"
  map.perspectives_accept 'perspectives/accept/:id', :controller => "perspectives", :action => "accept"
  map.linkrequest_new 'linkrequest/new', :controller => "linkrequest", :action => "new"
  map.linkrequest_destroy 'linkrequest/destroy/:id', :controller => "linkrequest", :action => "destroy"
  map.linkrequest_edit 'linkrequest/edit/:id', :controller => "linkrequest", :action => "edit"
  map.displayalllistingsgrid 'linkrequest/displayalllistingsgrid', :controller => "linkrequest", :action => "displayalllistingsgrid"
  map.collaborator_show 'collaborator/show', :controller => "collaborator", :action => "show"
  map.home_show 'home/show', :controller => "home", :action => "show"
  map.home_errorpage 'home/errorpage/:error_msg', :controller => "home", :action => "errorpage"
  map.users_show 'users/show', :controller => "users", :action => "show"
  map.users_new 'users/new', :controller => "users", :action => "new"
  map.users_forgot_username 'users/forgot_username', :controller => "users", :action => "forgot_username"
  map.users_forgot_password 'users/forgot_password', :controller => "users", :action => "forgot_password"
  map.users_logout 'users/logout', :controller => "users", :action => "logout"
  map.users_update_user_information 'users/update_user_information/:id', :controller => "users", :action => "update_user_information"
  map.activate 'users/activate/:activation_code', :controller => "users", :action => "activate"
  map.root :controller => "home"
  map.connect ':controller/:action/:id'

end


