class Day05 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    n = Nature.new(input: polymer)
    n.units
  end


  def p2
    arr = ('a'..'z').map do |c|
      exp = Regexp.new("[#{ c }#{ c.upcase }]")
      str = polymer + Nature::STAR
      str.gsub!(exp, '')

      n = Nature.new(input: str)

      [c, n.units]
    end
    shortest = arr.sort { |a, b| a.last <=> b.last }.first
    shortest.last
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def polymer
    @polymer ||= data.first
  end


  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  class Nature

    #========== CONFIGURATION =============================

    DESTRUCTORS ||= ('a'..'z').map { |c| "#{ c }#{ c.upcase }" }.freeze
    STAR        ||= '*'.freeze

    attr_reader :input, :output

    def initialize(hash)
      @input  = hash[:input].strip
      @output = reduce
    end


    #========== PUBLIC METHODS ============================

    def units
      output.size
    end


    #========== PRIVATE METHODS ===========================
    private

    def reduce
      str        = input + STAR         # preserves input
      is_first   = true
      has_change = false
      while is_first || has_change
        sz = str.size
        DESTRUCTORS.each do |d|
          str.gsub!(d, '')
          str.gsub!(d.reverse, '')
        end
        is_first   = false
        has_change = str.size < sz
      end
      str.gsub!(STAR, '')
    end

  end

end
