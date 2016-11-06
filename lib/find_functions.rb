module FindFunctions

  def find_by(method, input)
    return find_name(input) if method == :name
    find_id(input)          if method == :id
  end

  def find_name(input)
    all.find { |row| row.name.downcase == input.downcase }
  end

  def find_id(input)
    all.find { |row| row.id == input } if all
  end

  def find_all(method, input)
    return find_all_equivalent(method, input) if equivalence_needed?(method)
    find_all_strings(method, input)
  end

  def equivalence_needed?(method)
    method.to_s.include?("_id")  ||
    method == :unit_price        ||
    method == :status            ||
    method == :result            ||
    method == :credit_card_number
  end

  def find_all_equivalent(method, input)
    all.find_all { |row| row.send(method) == input }
  end

  def find_all_strings(method, input)
    all.find_all { |row| row.send(method).downcase.include?(input.downcase) }
  end

end
