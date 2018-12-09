module Day07
  module Helpers
    class Tree

      #----------------------------------------------------
      # Configuration
      #----------------------------------------------------

      # attributes
      attr_reader :rules

      # constructor
      def initialize(hash)
        @rules = hash[:rules]
      end


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

      def reset!
        nodes.values.each(&:reset!)
      end

    end
  end
end
