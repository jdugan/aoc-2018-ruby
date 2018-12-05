class Day03 < AbstractDay

  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def p1
    fabric.values.select { |v| v > 1 }.size
  end


  def p2
    id = nil
    patterns.each do |ph|
      pc = Pattern.new(ph)
      unless pc.overlap?(fabric)
        id = pc.id
        break
      end
    end
    id
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  def fabric
    @fabric ||= begin
      patterns.reduce({}) do |result, ph|
        pc = Pattern.new(ph)
        pc.keys.each do |k|
          result[k] = result[k].to_i + 1
        end
        result
      end
    end
  end

  def patterns
    @patterns ||= begin
      data.map do |s|
        parts  = s.strip.split(' ')
        id     = parts[0].gsub('#', '').to_i
        coords = parts[2].gsub(':', '').split(',').map(&:to_i)
        dims   = parts[3].split('x').map(&:to_i)

        { id: id, coords: coords, dims: dims }
      end
    end
  end


  #--------------------------------------------------------
  # Inner Classes
  #--------------------------------------------------------

  class Pattern

    attr_reader :id, :x, :y, :w, :h

    def initialize(hash)
      @id = hash[:id]
      @x  = hash[:coords].first
      @y  = hash[:coords].last
      @w  = hash[:dims].first
      @h  = hash[:dims].last
    end

    def keys
      xs = (x..x+w-1).to_a
      ys = (y..y+h-1).to_a
      xs.product(ys).map { |(a,b)| "#{ a }|#{ b }" }
    end

    def overlap?(result)
      keys.map { |k| result[k] > 1 }.any?
    end

  end

end
