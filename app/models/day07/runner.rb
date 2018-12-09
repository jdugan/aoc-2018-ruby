module Day07
  class Runner < AbstractRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      tree.linear_instructions
    end


    def p2
      tree.parallel_time(60, 5)     # step duration, worker pool size
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def tree
      @tree ||= begin
        regex = Regexp.new 'Step ([A-Z]) must be finished before step ([A-Z]) can begin.'
        rules = data.map do |r|
          r.split(regex).slice(1,2)
        end

        Day07::Helpers::Tree.new(rules: rules)
      end
    end

  end
end
