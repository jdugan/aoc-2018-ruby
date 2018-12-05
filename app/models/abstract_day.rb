class AbstractDay

  #--------------------------------------------------------
  # Configuration
  #--------------------------------------------------------

  # mixins
  include Singleton


  #--------------------------------------------------------
  # Class Methods
  #--------------------------------------------------------

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

  def data
    @data ||= begin
      str = File.read("#{ Rails.root }/data/#{ self.class.name.downcase }.txt")
      str.split("\n").reject(&:blank?)
    end
  end

end
