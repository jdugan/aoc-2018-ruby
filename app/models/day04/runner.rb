module Day04
  class Runner < BaseRunner

    #--------------------------------------------------------
    # Public Methods
    #--------------------------------------------------------

    def p1
      schedule.total_checksum
    end


    def p2
      schedule.frequent_checksum
    end


    #--------------------------------------------------------
    # Private Methods
    #--------------------------------------------------------
    private

    def schedule
      @schedule ||= begin
        regex = Regexp.new('\[(\d{4}-\d{2}-\d{2})\s(\d{2}):(\d{2})\]\s(.*)')

        daily_events = raw_data.sort.reduce({}) do |hash, s|
          parts = s.strip.split(regex).slice(1, 4)

          dt     = DateTime.parse(parts[0])
          hr     = parts[1].to_i
          min    = parts[2].to_i
          action = parts[3]
          yday   = (hr == 23) ? dt.yday + 1 : dt.yday

          hash[yday] ||= []
          hash[yday] << Helpers::Event.new(min: min, action: action)
          hash
        end

        shifts = daily_events.keys.sort.map do |id|
          Helpers::Shift.new(id: id, events: daily_events[id])
        end

        Helpers::Schedule.new(shifts: shifts)
      end
    end

  end
end
