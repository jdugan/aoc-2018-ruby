module Day13
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      coords = traffic.first_accident
      coords.join(",")
    end


    def p2
      coords = traffic.last_car_standing
      coords.join(",")
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def traffic
      @traffic ||= Helpers::Traffic.new(raw_data)
    end

  end
end
