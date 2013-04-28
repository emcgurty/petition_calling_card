Petitions::Application.routes.draw do |map|
  
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
  map.user_show 'user/show', :controller => "user", :action => "show"
  map.user_new 'user/new', :controller => "user", :action => "new"
  map.user_forgot_username 'user/forgot_username', :controller => "user", :action => "forgot_username"
  map.user_forgot_password 'user/forgot_password', :controller => "user", :action => "forgot_password"
  map.user_logout 'user/logout', :controller => "user", :action => "logout"
  map.user_update_user_information 'user/update_user_information/:id', :controller => "user", :action => "update_user_information"
  map.activate 'user/activate/:activation_code', :controller => "users", :action => "activate"
  map.root :controller => "home"
  map.connect ':controller/:action/:id'

end




