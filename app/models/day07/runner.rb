module Day07
  class Runner < BaseRunner

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
        nodes = raw_data.reduce({}) do |hash, s|
          s1, s2 = s.split(regex).slice(1, 2)

          n1 = hash[s1] ||= Helpers::Node.new(id: s1)
          n2 = hash[s2] ||= Helpers::Node.new(id: s2)

          n1.add_child(n2)
          n2.add_parent(n1)

          hash
        end

        Helpers::Tree.new(nodes: nodes)
      end
    end

  end
end
