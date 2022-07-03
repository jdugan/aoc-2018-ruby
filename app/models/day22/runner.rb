module Day22
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      cave.risk_level
    end


    def p2
      cave.shortest_time
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def cave
      @cave ||= begin
        depth  = raw_data.first.gsub('depth: ', '').strip.to_i
        coords = raw_data.last.gsub('target: ', '').split(',').map { |s| s.strip.to_i }

        Helpers::Cave.new(depth: depth, target_coords: coords)
      end
    end

  end
end
