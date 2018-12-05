class Day04 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    g = guards.sort_by(&:total_sleep).last            # longest guard
    g.id * g.favorite_minute
  end


  def p2
    g = guards.sort_by(&:favorite_frequency).last     # most frequent guard
    g.id * g.favorite_minute
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def guards
    @guards ||= begin
      guard_map.values
    end
  end

  def guard_map
    @guard_map ||= begin
      gh = schedule.reduce({}) do |hash, shift|
        gid = shift.guard_id
        hash[gid] ||= []
        hash[gid] << shift
        hash
      end
      gh.reduce({}) do |hash, (k,v)|
        hash[k] = Guard.new({ id: k, shifts: v })
        hash
      end
    end
  end

  def schedule
    @schedule ||= begin
      sch = data.reduce({}) do |hash, s|
        parts = s.strip.split('] ')
        sdt   = parts[0].gsub('[', '')
        evt   = parts[1].strip

        dt    = DateTime.strptime(sdt, '%Y-%m-%d %H:%M')
        hrs   = dt.strftime('%H').to_i
        mins  = dt.strftime('%M').to_i
        yday  = dt.yday
        yday  = yday + 1    if hrs == 23

        hash[yday] ||= []
        hash[yday] << [mins, evt]
        hash
      end
      days = sch.keys.map do |k|
        Shift.new({ id: k, events: sch[k] })
      end
      days.sort_by(&:id)
    end
  end


  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  #========== GUARD =======================================

  class Guard

    attr_reader :id, :shifts

    def initialize(hash)
      @id     = hash[:id]
      @shifts = hash[:shifts]
    end

    def favorite_frequency
      Array(favorite_tuple).last || -1    # some guards don't sleep
    end

    def favorite_minute
      favorite_tuple.first
    end

    def total_sleep
      shifts.map(&:sleep_length).sum
    end

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
        a = h.reduce([]) { |array, (k,v)| array << [k, v]; array }
        a.sort { |a, b| a.last <=> b.last }.last
      end
    end

  end

  #========== SHIFT =======================================

  class Shift

    attr_reader :id, :events

    def initialize(hash)
      @id     = hash[:id]
      @events = hash[:events]
    end

    def guard_id
      @guard_id ||= begin
        s = guard_text
        s.gsub!('Guard #', '')
        s.gsub!('begins shift', '')
        s.strip.to_i
      end
    end

    def sleep_length
      @sleep_length ||= sleep_minutes.size
    end

    def sleep_minutes
      @sleep_minutes ||= begin
        mins = []
        sleep_events.each_slice(2) do |se, we|
          sm = se.first
          wm = we.first
          mins << (sm..wm-1).to_a
        end
        mins.flatten
      end
    end

    private

    def guard_event
      @guard_event ||= begin
        events.find { |evt| evt.last.starts_with?('Guard') }
      end
    end

    def guard_text
      @guard_text ||= guard_event.last
    end

    def sleep_events
      @sleep_events ||= begin
        se = events.reject { |evt| evt.last == guard_text }
        se.sort { |a,b| a.first <=> b.first }
      end
    end

  end

end
