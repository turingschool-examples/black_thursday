# helper module for all repositories
module Repository
  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def all
    @repository.values.compact
  end

  def find_by_id(id)
    @repository[id]
  end

  def find_all_by_price(price)
    @repository.values.find_all do |item|
      item.unit_price == price
    end
  end

  def find_all_with_description(letters)
    @repository.values.find_all do |item|
      item.description.downcase.include?(letters.downcase)
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repository.values.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_price_in_range(range)
    @repository.values.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def find_by_name(merchant_name)
    @repository.values.find do |merchant|
      merchant.name.casecmp(merchant_name).zero?
    end
  end

  def find_all_by_name(name)
    @repository.values.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_merchant_id(input)
    @repository.values.find_all do |invoice|
      invoice.merchant_id == input
    end
  end

  def find_highest_id
    @repository.keys.max
  end

  

  def update(id, attributes)
    invoice = find_by_id(id)
    if invoice.nil?
    else
      temp_attr = sterilize_attributes(attributes, invoice)
      pairs = attributes.keys.zip(temp_attr.values)
      pairs.each do |pair|
        invoice.attributes[pair[0]] = pair[1]
      end
      invoice.attributes[:updated_at] = Time.now
    end
  end

  def sterilize_attributes(attributes, invoice)
    temp_attr = attributes.dup
    temp_attr[:id] = invoice.attributes[:id]
    unless temp_attr[:status].nil?
      temp_attr[:status] = temp_attr[:status].to_sym
    end
    temp_attr[:customer_id] = invoice.attributes[:customer_id]
    temp_attr[:merchant_id] = invoice.attributes[:merchant_id]
    temp_attr[:created_at] = invoice.attributes[:created_at]
    temp_attr
  end

  def delete(id)
    @repository[id] = nil
  end
end