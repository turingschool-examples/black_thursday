module Repository
  attr_reader :elements
  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def from_csv(csv)
    records = CSV.read(csv, headers: true)
    elements = (0..(records.count - 1)).to_a.map do |index|
      set_element_hash(records, index)
    end
    build_elements_hash(elements)
  end

  def set_element_hash(records, index)
    records[index].to_a.map do |row|
      [row[0].to_sym, row[1]]
    end.to_h
  end

  def all
    @elements.values
  end

  def find_by_id(id_number)
    @elements[id_number]
  end

  def find_by_name(name)
    all.find do |element|
      element.name.casecmp(name).zero?
    end
  end

  def find_all_with_description(text)
    all.find_all do |element|
      element.description.downcase.include?(text.downcase)
    end
  end

  def find_all_by_name(name)
    all.find_all do |element|
      element.name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_status(status)
    all.find_all do |element|
      element.status == status.to_sym
    end
  end

  def find_all_by_price(price)
    all.find_all do |element|
      element.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |element|
      cost = element.unit_price_to_dollars
      range.include?(cost)
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |element|
      element.merchant_id == merch_id
    end
  end

  def find_all_by_customer_id(cust_id)
    all.find_all do |element|
      element.customer_id == cust_id
    end
  end

  def create_id_number
    if @elements.empty?
      1
    else
      @elements.keys.max + 1
    end
  end

  def update(id, attributes)
    element = find_by_id(id)
    element.attributes[:name] = attributes[:name] if attributes[:name]
    element.attributes[:description] = attributes[:description] if attributes[:description]
    element.attributes[:unit_price] = attributes[:unit_price] * 100 if attributes[:unit_price]
    element.attributes[:customer_id] = attributes[:customer_id] if attributes[:customer_id]
    element.attributes[:status] = attributes[:status] if attributes[:status]
    element.attributes[:updated_at] = Time.now if element
    element.attributes[:invoice_id] = attributes[:invoice_id] if attributes[:invoice_id]
    element.attributes[:item_id] = attributes[:item_id] if attributes[:item_id]
    element.attributes[:quantity] = attributes[:quantity] if attributes[:quantity]
    element.attributes[:credit_card_number] = attributes[:credit_card_number] if attributes[:credit_card_number]
    element.attributes[:credit_card_expiration_date] = attributes[:credit_card_expiration_date] if attributes[:credit_card_expiration_date]
    element.attributes[:result] = attributes[:result] if attributes[:result]
  end

  def delete(id)
    @elements.delete(id)
  end

  def find_all_by_item_id(item_id)
    all.find_all do |element|
      element.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |element|
      element.invoice_id == invoice_id
    end
  end

  def find_all_by_credit_card_number(credit_card_number)
    all.find_all do |element|
      element.credit_card_number == credit_card_number
    end
  end

  def find_all_by_result(result)
    all.find_all do |element|
      element.result == result
    end
  end

  def find_all_by_first_name(first_name)
    all.find_all do |element|
      element.first_name == first_name
    end
  end

  def find_all_by_last_name(last_name)
    all.find_all do |element|
      element.last_name == last_name
    end
  end
end
