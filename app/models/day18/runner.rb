module Day18
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      grid.reset!
      grid.value_after(10)
    end


    def p2
      grid.reset!
      grid.value_after(1000)    # cycle repeats every 28 days at this point
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def grid
      @grid ||= begin
        strs = raw_data.reduce([]) do |array, str|
          sqs   = str.strip.split('')
          array << sqs
          array
        end

        Helpers::Grid.new(strs, 0)
      end
    end

  end
end
