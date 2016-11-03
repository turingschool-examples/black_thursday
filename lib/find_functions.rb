module FindFunctions

  def find_by(method, input)
    return find_name(input) if method == :name
    find_id(input)          if method == :id
  end

  def find_name(input)
    all.find {|row| row.name.downcase == input.downcase}
  end

  def find_id(input)
    all.find {|row| row.id == input}
  end

  def find_all(method, input)
    return find_all_prices(input)    if method == :unit_price
    return find_all_merch_ids(input) if method == :merchant_id
    find_all_strings(method, input)
  end

  def find_all_prices(input)
    all.find_all {|row| row.unit_price.to_f == input.to_f}
  end

  def find_all_merch_ids(input)
    all.find_all {|row| row.merchant_id == input}
  end

  def find_all_strings(method, input)
    all.find_all do |row|
      row = row.send(method).downcase
      row.include?(input.downcase)
    end
  end

end
