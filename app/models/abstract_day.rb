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
    obj = self.instance
    obj.p1
  end

  def self.p2
    obj = self.instance
    obj.p2
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
