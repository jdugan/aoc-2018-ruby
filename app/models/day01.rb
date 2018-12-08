class Day01 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    calculator.sum
  end

  def p2
    calculator.first_duplicate
  end

  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def calculator
    @calculator ||= Calculator.new(data: test_data)
  end


  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  # Calculator encapsulates all the logic required to
  # handle the frequency stream.
  #+++++++++++++++++++++++++++++++++++++++++++++++++++++++++

  class Calculator

    #========== CONFIGURATION =============================

    attr_reader :frequencies

    def initialize(hash)
      @frequencies = Array(hash[:data]).map(&:to_i)
    end


    #========== PUBLIC METHODS ============================

    def first_duplicate
      fmap = { 0 => true }
      freq = 0
      dupl = nil

      while dupl.nil? do                  # the list must be looped many times
        frequencies.each do |fc|          # to find a duplicate frequency.
          nf = freq + fc
          if fmap.has_key?(nf)
            dupl = nf
            break
          else
            fmap[nf] = true
            freq     = nf
          end
        end
      end
      dupl
    end

    def sum
      frequencies.sum
    end

  end

end
