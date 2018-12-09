class AbstractRunner

  #--------------------------------------------------------
  # Configuration
  #--------------------------------------------------------

  # constants
  MODES ||= [:prod, :test].freeze

  # mixins
  include Singleton

  # attributes
  attr_accessor :mode


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

  #========== ATTRIBUTES ==================================

  def data_path
    @data_path ||= begin
      folder = self.class.name.deconstantize.downcase
      "#{ Rails.root }/app/models/#{ folder }/data"
    end
  end

  def mode
    @mode ||= begin
      em = ENV['AOC_MODE'].to_s.to_sym
      MODES.find { |m| m == em } || :prod
    end
  end


  #========== DATA HELPERS ================================

  def data
    @data ||= begin
      str = File.read("#{ data_path }/#{ mode }.txt")
      str.split("\n").reject(&:blank?)
    end
  end


  #========== STATE HELPERS ===============================

  MODES.each do |m|
    define_method "#{ m }?" do
      mode == m
    end
  end

end
