module Repository
  attr_reader :elements

  def from_csv(csv) # module
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
    all.find do |item|
      item.name.casecmp(name).zero?
    end
  end

  def find_all_with_description(text)
    all.find_all do |item|
      item.description.downcase.include?(text.downcase)
    end
  end

  def find_all_by_price(price)
    all.find_all do |item|
      item.unit_price_to_dollars == price
    end
  end

  def find_all_by_price_in_range(range)
    all.find_all do |item|
      cost = item.unit_price_to_dollars
      range.include?(cost)
    end
  end

  def find_all_by_merchant_id(merch_id)
    all.find_all do |item|
      item.merchant_id == merch_id
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
    item = find_by_id(id)
    item.attributes[:name] = attributes[:name] if attributes[:name]
    item.attributes[:description] = attributes[:description] if attributes[:description]
    item.attributes[:unit_price] = attributes[:unit_price] if attributes[:unit_price]
    item.attributes[:updated_at] = Time.now
  end

  def delete(id)
    @elements.delete(id)
  end
end
