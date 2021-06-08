module HelperMethods

  def find_by_id(id)
    result = all.find do |line|
      line.id.to_s == id.to_s
    end
  end

  def find_by_name(name)
    result = all.find do |line|
      line.name.to_s.downcase == name.to_s.downcase
    end
  end

  def find_all_by_name(name_frag)
    result = all.select do |line|
      line.name.to_s.downcase.include?(name_frag.to_s.downcase)
    end
  end

  def create_new_id
    result = all.max_by do |line|
      line.id.to_i
    end
    result.id.to_i + 1
  end

  def delete(id)
    result = find_by_id(id)
    unless result == nil
      all.delete_if { |instance| instance.id == result.id }
    end
  end

  def find_all_by_status(status)
    result = all.select do |line|
      line.status == status
    end
  end

  def find_all_by_invoice_id(invoice_id)
    result = all.select do |line|
      line.invoice_id.to_i == invoice_id.to_i
    end
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

end
