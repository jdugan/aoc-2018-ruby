module Day03
  class Runner < BaseRunner

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
      @fabric ||= Helpers::Fabric.new(patterns: patterns)
    end

    def patterns
      @patterns ||= begin
        regex = Regexp.new('^\#(\d+) @ (\d+),(\d*): (\d+)x(\d+)$')
        keys  = [:id, :x, :y, :w, :h]

        raw_data.map do |s|
          values = s.split(regex).slice(1, 5).map(&:to_i)
          attrs  = keys.zip(values).to_h

          Helpers::Pattern.new(attrs)
        end
      end
    end

  end
end
