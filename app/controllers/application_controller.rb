class ApplicationController < ActionController::Base

  #-------------------------------------------------
  # Configuration
  #-------------------------------------------------

  # define helper settings
  helper        :all

  # establish security settings
  protect_from_forgery with: :exception

  # layout
  layout 'application'

end
