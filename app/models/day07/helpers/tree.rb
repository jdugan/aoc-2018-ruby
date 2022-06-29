module Day07
  module Helpers
    class Tree < Tableless

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      attr_accessor :nodes


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def linear_instructions
        reset!

        str = ''
        while n = next_available
          str << n.consume!
        end
        str
      end

      def parallel_time(duration, pool_size)
        reset!

        crew  = Crew.new(size: pool_size)
        nas   = next_available_set
        clock = 0

        while crew.busy? || nas.present?
          crew.idle_workers.each do |w|
            if n = next_available_set.shift
              w.assign!(n, duration)
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


      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------
      private

      def next_available
        next_available_set.first
      end

      def next_available_set
        an = nodes.values.select { |n| n.available? }
        na = an.sort { |a,b| a.id <=> b.id }
      end

      def reset!
        nodes.values.each(&:reset!)
      end

    end
  end
end
