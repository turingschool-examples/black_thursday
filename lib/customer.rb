require_relative 'element'

# This class defines InvoiceItems
class Customer
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end

  def first_name
    @attributes[:first_name]
  end

  def last_name
    @attributes[:last_name]
  end

  def update(states)
    super(states)
    attributes[:first_name] = states[:first_name] if states[:first_name]
    attributes[:last_name] = states[:last_name] if states[:last_name]
  end
end
