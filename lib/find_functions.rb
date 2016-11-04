require 'pry'
module FindFunctions

  def find_by(method, input)
    return find_name(input) if method == :name
    find_id(input)          if method == :id
  end

  def find_name(input)
    all.find { |row| row.name.downcase == input.downcase }
  end

  def find_id(input)
    all.find { |row| row.id == input }
  end

  def find_all(method, input)
    return find_all_equivalent(method, input) if equivalence_needed?(method)
    find_all_strings(method, input)
  end

  def equivalence_needed?(method)
    method == :unit_price  || 
    method == :merchant_id || 
    method == :customer_id ||
    method == :status
  end

  def find_all_equivalent(method, input)
    all.find_all { |row| row.send(method) == input }
  end

  def find_all_strings(method, input)
    all.find_all do |row|
      row = row.send(method).downcase
      row.include?(input.downcase)
    end
  end

end
