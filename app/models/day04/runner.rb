module Day04
  class Runner < AbstractRunner

    #--------------------------------------------------------
    # Public Methods
    #--------------------------------------------------------

    def p1
      schedule.total_checksum
    end


    def p2
      schedule.frequent_checksum
    end


    #--------------------------------------------------------
    # Private Methods
    #--------------------------------------------------------
    private

    def schedule
      @schedule ||= Helpers::Schedule.new(data)
    end

  end
end
