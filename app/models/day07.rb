class Day07 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    tree.reset!
    tree.linear_instructions
  end


  def p2
    tree.reset!
    tree.parallel_time
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def rules
    @rules ||= begin
      exp = Regexp.new 'Step ([A-Z]) must be finished before step ([A-Z]) can begin.'
      data.map do |r|
        r.split(exp).slice(1,2)
      end
    end
  end

  def tree
    @tree ||= begin
      Tree.new(rules: rules)
    end
  end


  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  class Node

    #========== CONFIGURATION =============================

    DELAYS ||= ('A'..'Z').to_a.freeze

    attr_reader :id, :parents, :children, :state, :consumed

    def initialize(hash)
      @id       = hash[:id]
      @parents  = []
      @children = []
      @state    = :available
      @consumed = false
    end

    #========== PUBLIC METHODS ============================

    #---------- actions -----------------------------------

    def accept!
      @state = :accepted
      id
    end

    def consume!
      @state = :consumed
      id
    end

    def reset!
      @state = :available
    end

    #---------- getters -----------------------------------

    def delay
      DELAYS.index(id) + 1
    end

    #---------- setters -----------------------------------

    def add_child(node)
      @children << node  unless children.include?(node)
    end

    def add_parent(node)
      @parents << node  unless parents.include?(node)
    end

    #---------- state helpers -----------------------------

    def accepted?
      state == :accepted
    end

    def available?
      (state == :available) && (parents.empty? || parents.all?(&:consumed?))
    end

    def consumed?
      state == :consumed
    end

  end


  class Tree

    #========== CONFIGURATION =============================

    DURATION ||= 60.freeze
    WORKERS  ||= 5.freeze

    attr_reader :rules

    def initialize(hash)
      @rules = hash[:rules]
    end


    #========== PUBLIC METHODS ============================

    def linear_instructions
      str = ''
      while n = next_available
        str << n.consume!
      end
      str
    end

    def parallel_time
      crew  = Crew.new(size: WORKERS)
      nas   = next_available_set
      clock = 0

      while crew.busy? || nas.present?
        crew.idle_workers.each do |w|
          if n = next_available_set.shift
            w.assign!(n, DURATION)
          end
        end
        crew.busy_workers.each do |w|
          w.work!
        end
        clock = clock + 1
        nas   = next_available_set
      end
      clock
    end

    def reset!
      nodes.values.each(&:reset!)
    end


    #========== PRIVATE METHODS ===========================
    private

    def next_available
      next_available_set.first
    end

    def next_available_set
      an = nodes.values.select { |n| n.available? }
      na = an.sort { |a,b| a.id <=> b.id }
    end

    def nodes
      @nodes ||= begin
        rules.reduce({}) do |hash, (s1, s2)|
          n1 = hash[s1] ||= Node.new(id: s1)
          n2 = hash[s2] ||= Node.new(id: s2)

          n1.add_child(n2)
          n2.add_parent(n1)

          hash
        end
      end
    end

  end

  class Crew

    #========== CONFIGURATION =============================

    attr_reader :workers

    def initialize(hash)
      @workers = hash[:size].times.map { Worker.new } || []
    end

    #========== PUBLIC METHODS ============================

    #---------- collections -------------------------------

    def busy_workers
      workers.select(&:busy?)
    end

    def idle_workers
      workers.select(&:idle?)
    end

    #---------- state helpers -----------------------------

    def busy?
      busy_workers.size > 0
    end

  end

  class Worker

    #========== CONFIGURATION =============================

    attr_reader :node, :wait

    def initialize(hash={})
      @node = hash[:node] || nil
      @wait = hash[:wait] || 0
    end


    #========== PUBLIC METHODS ============================

    #---------- actions -----------------------------------

    def assign!(n, dur)
      if idle?
        n.accept!
        @node = n
        @wait = n.delay + dur
      end
    end

    def work!
      if busy?
        @wait = wait - 1
        if idle?
          status = [:idle, node.id]
          node.consume!
          @node = nil
        else
          status = [:busy, node.id]
        end
      else
        status = [:idle, nil]
      end
      status
    end

    #---------- state helpers -----------------------------

    def busy?
      wait > 0
    end

    def idle?
      wait < 1
    end

  end

end
