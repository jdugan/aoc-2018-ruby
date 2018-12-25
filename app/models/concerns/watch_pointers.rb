module WatchPointers
  extend ActiveSupport::Concern

  #--------------------------------------------------------
  # Configuration
  #--------------------------------------------------------

  included do

    # attributes
    attr_accessor :ip
    
  end


  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  #========== ACTIONS =====================================

  def increment_ip_value!
    registry[ip] = registry[ip] + 1
  end


  #========== ATTRIBUTES ==================================

  def ip_value
    registry[ip]
  end

end
