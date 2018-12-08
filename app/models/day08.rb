class Day08 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    tree.root.simple_value
  end


  def p2
    tree.root.complex_value
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def tree
    @tree ||= begin
      numbers = data.first.split(' ').map(&:to_i)
      Tree.new(numbers: numbers)
    end
  end


  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Tree holds all the nodes and is responsible for
  # parsing the data into some understandable set of
  # relations.
  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  class Tree

    #========== CONFIGURATION =============================

    attr_reader :numbers, :dashes

    def initialize(hash)
      @numbers = hash[:numbers]
    end


    #========== PUBLIC METHODS ============================

    def root
      @root ||= begin
        nums   = numbers.map { |n| n }  # make a copy
        header = nums.shift(2)
        root   = Node.new(header: header, parent: nil)
        add_children(nums, root)
        root
      end
    end



    #========== PRIVATE METHODS ===========================
    private

    def add_children(nums, node)
      if node.neutered?
        node.metadata = nums.shift(node.expected_metadata)
        if node.parent
          node.parent.add_child(node)
          add_children(nums, node.parent)
        end
      else
        header = nums.shift(2)
        child  = Node.new(header: header, parent: node)
        add_children(nums, child)
      end
    end

  end


  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Node represents an individual item in the data
  # structure and encapsulates any claculations and
  # state values related to the item.
  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  class Node

    #========== CONFIGURATION =============================

    attr_reader   :header, :parent, :children
    attr_accessor :metadata

    def initialize(hash)
      @header   = hash[:header]
      @parent   = hash[:parent]
      @children = []
      @metadata = []
    end


    #========== PUBLIC METHODS ============================

    #---------- calculations ------------------------------

    def simple_value
      metadata.sum + children.map(&:simple_value).sum
    end

    def complex_value
      if barren?
        metadata.sum
      else
        indices = metadata.map { |n| n - 1 }.reject { |n| n < 0 }
        kids    = indices.map { |i| children[i] }.compact
        kids.map(&:complex_value).sum
      end
    end

    #---------- setters -----------------------------------

    def add_child(node)
      @children << node
    end

    def add_parent(node)
      @parent = node
    end

    #---------- state helpers -----------------------------

    def barren?
      expected_children == 0
    end

    def expected_children
      header.first
    end

    def expected_metadata
      header.last
    end

    def fertile?
      !neutered?
    end

    def filled?
      metadata.size == expected_metadata
    end

    def neutered?
      children.size == expected_children
    end

    def valid?
      neutered? && filled?
    end

  end

end
