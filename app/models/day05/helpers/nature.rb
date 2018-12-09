module Day05
  module Helpers
    Nature = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def simple_reduction
        reduce(polymer).size
      end

      def complex_reduction
        arr = ('a'..'z').map do |c|
          exp = Regexp.new("[#{ c }#{ c.upcase }]")
          str = polymer
          str.gsub!(exp, '')

          rs = reduce(str)

          [rs.size, c]
        end
        tuple = arr.sort.first
        tuple.first
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== DATA ====================================

      def polymer
        String.new(data.first)
      end


      #========== HELPERS =================================

      def destructors
        @destructors ||= ('a'..'z').map { |c| "#{ c }#{ c.upcase }" }
      end

      def reduce(str)
        is_first   = true
        has_change = false
        while is_first || has_change
          sz = str.size
          destructors.each do |d|
            str.gsub!(d, '')
            str.gsub!(d.reverse, '')
          end
          is_first   = false
          has_change = str.size < sz
        end
        str
      end

    end
  end
end
