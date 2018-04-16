

class Customer
  attr_reader   :attributes

  def initialize(data)
    modify(data)
    @attributes = data
  end

  def modify(data)
    data[:id] = data[:id].to_i
    data[:invoice_id] = data[:invoice_id].to_i
    data[:credit_card_number] = data[:credit_card_number]
    data[:credit_card_expiration_date] = data[:credit_card_expiration_date]
    data[:result] = data[:result].to_sym
    data[:created_at] = Time.parse(data[:created_at])
    data[:updated_at] = Time.parse(data[:updated_at])
    data
  end


end
