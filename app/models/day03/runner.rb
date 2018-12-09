module Day03
  class Runner < AbstractRunner

    #--------------------------------------------------------
    # Public Methods
    #--------------------------------------------------------

    def p1
      fabric.overlapped_coords.size
    end


    def p2
      fabric.unencumbered_pattern_id
    end


    #--------------------------------------------------------
    # Private Methods
    #--------------------------------------------------------
    private

    def fabric
      @fabric ||= Helpers::Fabric.new(data)
    end

  end
end
