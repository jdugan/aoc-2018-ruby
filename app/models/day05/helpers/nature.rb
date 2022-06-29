module Day05
  module Helpers
    class Nature < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :polymer


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def simple_reduction
        reduce(polymer).size
      end

      def complex_reduction
        arr = ('a'..'z').map do |c|
          exp = Regexp.new(c, true)      # case insensitive
          str = polymer.gsub(exp, '')

          [reduce(str).size, c]
        end
        tuple = arr.sort.first
        tuple.first
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== HELPERS =================================

      def destructors(str)
        ('a'..'z').select { |c| str.include?(c) }.map { |c| "#{ c }#{ c.upcase }" }
      end

      def reduce(str)
        has_change = true
        while has_change
          prev_size = str.size
          destructors(str).each do |exp|
            str = str.gsub(exp, '').gsub(exp.reverse, '')
          end
          has_change = str.size < prev_size
        end
        str
      end

    end
  end
end
