class BaseRunner

  #--------------------------------------------------------
  # Configuration
  #--------------------------------------------------------

  # mixins
  include Singleton


  #--------------------------------------------------------
  # Class Methods
  #--------------------------------------------------------

  #========== PUZZLES =====================================

  def self.both
    res1 = nil
    res2 = nil
    obj = self.instance
    time = Benchmark.realtime do
      res1 = obj.p1
      res2 = obj.p2
    end
    puts "Real: #{ (time * 1000).round(3) }ms"
    [res1, res2]
  end

  def self.p1
    res = nil
    obj = self.instance
    time = Benchmark.realtime do
      res = obj.p1
    end
    puts "Real: #{ (time * 1000).round(3) }ms"
    res
  end

  def self.p2
    res = nil
    obj = self.instance
    time = Benchmark.realtime do
      res = obj.p2
    end
    puts "Real: #{ (time * 1000).round(3) }ms"
    res
  end


  #--------------------------------------------------------
  # Private Methods
  #--------------------------------------------------------
  private

  #========== DATA HELPERS ================================

  def data_path
    @data_path ||= begin
      folder = self.class.name.deconstantize.downcase
      "#{ Rails.root }/public/data/#{ folder }"
    end
  end

  def raw_data
    @raw_data ||= begin
      str = File.read("#{ data_path }/input.txt")
      str.split("\n").reject(&:blank?)
    end
  end

end
