require_relative 'sales_engine'

module Repository
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |element|
      id == element.id
    end
  end

  def find_by_name(name)
    @repository.find do |element|
      name.downcase == element.name.downcase
    end
  end

  def find_all_by_name(name)
    @repository.find_all do |element|
      element.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |element|
      id == element.merchant_id
    end
  end

  def find_all_by_invoice_id(id)
    @repository.find_all do |element|
      id == element.invoice_id
    end
  end

  def update(id, attributes)
    object = find_by_id(id)
    unless object.nil?
      object.name        = attributes[:name] if attributes[:name]
      object.first_name  = attributes[:first_name] if attributes[:first_name]
      object.last_name   = attributes[:last_name] if attributes[:last_name]
      object.description = attributes[:description] if attributes[:description]
      object.unit_price  = attributes[:unit_price] if attributes[:unit_price]
      object.status      = attributes[:status] if attributes[:status]
      object.quantity    = attributes[:quantity] if attributes[:quantity]
      object.result      = attributes[:result] if attributes[:result]
      exp_date = attributes[:credit_card_expiration_date]
      object.credit_card_expiration_date = exp_date if exp_date
      cc_number = attributes[:credit_card_number]
      object.credit_card_number = cc_number if cc_number
      object.updated_at  = Time.now unless object.class == Merchant
    end
    return nil
  end


  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
