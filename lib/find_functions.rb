module FindFunctions

  def find_by(collection, method, input)
    collection.find {|row| row.send(method) == input}
  end

  def find_all(collection, method, input)
    return find_all_prices(collection, input)    if method == :unit_price
    return find_all_merch_ids(collection, input) if method == :merchant_id
    find_all_strings(collection, method, input)
  end

  def find_all_prices(collection, input)
    collection.find_all {|row| row.unit_price.to_f == input.to_f }
  end

  def find_all_merch_ids(collection, input)
    collection.find_all {|row| row.merchant_id == input }
  end

  def find_all_strings(collection, method, input)
    collection.find_all do |row|
      row = row.send(method).downcase
      row.include?(input.downcase)
    end
  end

end
