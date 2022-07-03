module Day21
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      emulator.shortest_r0
    end


    def p2
      emulator.longest_r0
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def emulator
      @emulator ||= begin
        ip = raw_data.first.gsub('#ip', '').strip.to_i

        commands = {}
        raw_data.slice(1, raw_data.size).each.with_index do |str, index|
          regex = Regexp.new('^(\w{4})\s+(\d+)\s+(\d+)\s+(\d+)$')
          parts = str.split(regex).slice(1, 4)
          name  = parts.shift

          commands[index] = [name] + parts.map(&:to_i)
        end

        Helpers::Emulator.new(ip: ip, commands: commands)
      end
    end

  end
end
