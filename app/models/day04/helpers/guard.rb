module Day04
  module Helpers
    class Guard < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :id
      attr_accessor :shifts


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def favorite_count
        Array(favorite_tuple).last || -1      # some guards don't sleep
      end

      def favorite_minute
        Array(favorite_tuple).first || -1     # some guards don't sleep
      end

      def total_sleep
        shifts.map(&:sleep_length).sum
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      def favorite_tuple
        @favorite_tuple ||= begin
          h = shifts.reduce({}) do |hash, shift|
            shift.sleep_minutes.each do |sm|
              hash[sm] ||= 0
              hash[sm]   = hash[sm] + 1
            end
            hash
          end
          a = h.to_a
          a.sort_by(&:last).last
        end
      end
    end
  end
end
