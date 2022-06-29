module Day12
  class Runner < BaseRunner

    #------------------------------------------------------
    # Public Methods
    #------------------------------------------------------

    def p1
      world.total_at(20)
    end


    def p2
      world.total_at(50000000000)
    end


    #------------------------------------------------------
    # Private Methods
    #------------------------------------------------------
    private

    def world
      @world ||= begin
        state = raw_data.first.gsub('initial state: ', '').strip
        rules = raw_data.slice(1..-1).map do |str|
          regex = Regexp.new('^([\.#]{5}) => ([\.#])$')
          parts = str.split(regex).slice(1, 2)

          parts.first   if parts.last == '#'
        end.compact

        Helpers::World.new(initial_state: state, rules: rules)
      end
    end

  end
end
