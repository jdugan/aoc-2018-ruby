#----------------------------------------------------------
# Preconditions
#----------------------------------------------------------

# load system dependencies
require_relative 'boot'

# load rails + framework parts
require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "rails/test_unit/railtie"

# load appropriate gems
Bundler.require(*Rails.groups)


#----------------------------------------------------------
# Configuration
#----------------------------------------------------------

module Advent
  class Application < Rails::Application

    #========== DEFAULTS (RAILS) ==========================

    config.load_defaults 5.1


    #========== DEFAULTS (API) ============================

    config.api_only = true
    
  end
end
