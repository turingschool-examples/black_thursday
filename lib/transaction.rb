
class Transaction
  attr_reader :attributes


  def initialize(data)
    modify(data)
    @attributes = data
  end

  def modify(data)
    data[:id] = data[:id].to_i
    data[:invoice_id] = data[:invoice_id].to_i
    data[:credit_card_number] = data[:credit_card_number].to_i
    data[:credit_card_expiration_date] = data[:credit_card_expiration_date]
    data[:result] = data[:result]
    data[:created_at] = Time.parse(data[:created_at])
    data[:updated_at] = Time.parse(data[:updated_at])
    data
  end

  def id
    @attributes[:id]
  end

  def invoice_id
    @attributes[:invoice_id]
  end

  def credit_card_number
    @attributes[:credit_card_number]
  end

  def credit_card_expiration_date
    @attributes[:credit_card_expiration_date]
  end

  def result
    @attributes[:result]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

end
