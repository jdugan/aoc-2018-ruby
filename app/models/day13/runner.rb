module Day13
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      traffic.first_accident
    end


    def p2
      traffic.last_car_standing
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def traffic
      @traffic ||= Helpers::Traffic.new(data)
    end

  end
end
