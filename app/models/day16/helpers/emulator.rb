module Day16
  module Helpers
    Emulator = Struct.new(:data) do

      #----------------------------------------------------
      # Public Methods
      #----------------------------------------------------

      def interrogate
        count = 0
        experiments.each do |e|
          if e.possible_opcode_names.size > 2
            count = count + 1
          end
        end
        count
      end

      def run
        w = Watch.new(registry: [0, 0, 0, 0])
        commands.each do |cmd|
          num  = cmd.shift
          name = opcode_hash[num]

          w.send(name, *cmd)
        end
        w.registry.first
      end


      #----------------------------------------------------
      # Private Methods
      #----------------------------------------------------
      private

      #========== MEMOS ===================================

      def commands
        @commands ||= begin
          a = []
          data.each_slice(3) do |strs|
            unless strs.first.starts_with?('Before')
              strs.each do |str|
                cmd = str.strip.split(/\s+/).map(&:to_i)
                a << cmd
              end
            end
          end
          a
        end
      end

      def experiments
        @experiments ||= begin
          a = []
          data.each_slice(3) do |bstr, cstr, astr|
            if bstr.starts_with?('Before')
              ba = bstr.strip.split(/^Before:\s+\[(\d, \d, \d, \d)\]$/).last.split(', ').map(&:to_i)
              ca = cstr.strip.split(/\s+/).map(&:to_i)
              aa = astr.strip.split(/^After:\s+\[(\d, \d, \d, \d)\]$/).last.split(', ').map(&:to_i)

              a << Experiment.new(ca, [ ba, aa])
            end
          end
          a
        end
      end

      def opcode_hash
        @opcode_hash ||= begin
          h  = {}
          while h.size < opcode_limit
            ph = possibles_hash
            sh = ph.select { |k,v| v.size == 1 }
            sh.each do |sk, sv|
              h[sk] = sv.first
              ph.delete(sk)
              ph.each do |pk, pv|
                ph[pk] = pv - sv
              end
            end
          end
          h
        end
      end

      def opcode_limit
        @opcode_limit ||= Watch.new.operation_names.size
      end

      def possibles_hash
        @possibles_hash ||= begin
          oh = {}
          experiments.each do |e|
            k = e.opcode_number
            v = e.possible_opcode_names

            oh[k] = Array(oh[k]) | v
          end
          oh.each_pair { |k,v| oh[k] = v.sort! }
          oh
        end
      end

    end
  end
end
