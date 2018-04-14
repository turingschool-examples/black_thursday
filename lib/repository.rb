module Repository
  attr_reader :elements

  def inspect
    "#<#{self.class} #{@elements.size} rows>"
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

  def find_all_by_name(name)
    all.find_all do |element|
      element.name.downcase.include?(name.downcase)
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

  def create_id_number
    if @elements.empty?
      1
    else
      @elements.keys.max + 1
    end
  end

  def update(id, attributes)
    element = find_by_id(id)
    return if element.nil?
    element.update(attributes)
  end

  def delete(id)
    @elements.delete(id)
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |element|
      element.invoice_id == invoice_id
    end
  end
end
