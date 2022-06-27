module Day02
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      calculator.checksum
    end


    def p2
      calculator.common_characters
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def boxes
      @boxes ||= begin
        raw_data.map do |id|
          Helpers::Box.new(id: id.strip)
        end
      end
    end

    def calculator
      @calculator ||= Helpers::Calculator.new(boxes: boxes)
    end

  end
end
