module Day02
  class Runner < AbstractRunner

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

    def calculator
      @calculator ||= begin
        boxes = data.map { |id| Day02::Helpers::Box.new(id.strip, {}) }
        Day02::Helpers::Calculator.new(boxes)
      end
    end

  end
end
