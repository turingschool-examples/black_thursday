require_relative 'element'

# This class defines Transaction
class Transaction
  include Element

  def initialize(attributes, engine = nil)
    @attributes = attributes
    @engine = engine
  end

  def credit_card_number
    @attributes[:credit_card_number]
  end

  def credit_card_expiration_date
    @attributes[:credit_card_expiration_date]
  end

  def result
    @attributes[:result].to_sym
  end

  def update(states)
    super(states)
    ccn = :credit_card_number
    cce = :credit_card_expiration_date
    attributes[ccn] = states[ccn] if states[ccn]
    attributes[cce] = states[cce] if states[cce]
    attributes[:result] = states[:result] if states[:result]
  end
end
