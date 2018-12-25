class Tableless

  #--------------------------------------------------------
  # Configuration
  #--------------------------------------------------------

  # mixins
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  # constructor
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{ name }=", value)
    end
  end


  #--------------------------------------------------------
  # Public Methods
  #--------------------------------------------------------

  def persisted?
    false
  end

end
