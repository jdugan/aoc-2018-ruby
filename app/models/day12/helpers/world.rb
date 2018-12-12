module Day12
  module Helpers
    World = Struct.new(:data) do

      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------

      def total_at(generation)
        score_at(generation)
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== CALCULATIONS ============================

      def next_garden_attrs(offset, state)
        po = offset
        ps = '......' + state + '....'

        ni = (0..ps.size-3).to_a
        ns = ni.map do |i|
          str = ps.slice(i, 5)
          val = rules.include?(str) ? '#' : '.'
        end.join
        no = po - 4 + ns.index('#')
        ns.gsub!(/^\.*/, '')                  # shorten string and reset
        ns.gsub!(/\.*$/, '')                  # the offset

        [no, ns]
      end

      def score(offset, state)
        sum = 0
        state.split('').each_with_index do |s, i|
          if s == '#'
            sum = sum + i + offset
          end
        end
        sum
      end

      def score_at(generation)
        offset = 0
        state  = initial_state

        scores = []
        diffs  = []
        flux   = true
        n      = 0

        while flux && n < generation
          offset, state = next_garden_attrs(offset, state)

          scores << score(offset, state)
          diffs  << (scores[-1] - scores[-2]) rescue 0
          if n > 25
            scores = scores.last(25)            # diffs eventually stabilse; no idea why but
            diffs  = diffs.last(25)             # they do. here we trap the stabilisation and
            flux   = diffs.uniq.size > 1        # break so we can jump to the answer.
          else
            flux   = true
          end

          n = n + 1
        end

        jump = (n == generation) ? 0 : (generation - n) * diffs.last
        scores.last + jump
      end


      #==========  DATA ===================================

      def initial_state
        @initial_state ||= begin
          data.first.gsub('initial state: ', '').strip
        end
      end

      def rules
        @rules ||= begin
          a = data.slice(1..-1).map do |str|
            regex = Regexp.new('^([\.#]{5}) => ([\.#])$')
            parts = str.split(regex).slice(1, 2)

            parts.first   if parts.last == '#'
          end
          a.compact
        end
      end

    end
  end
end
