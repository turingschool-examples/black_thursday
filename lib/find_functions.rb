module FindFunctions

  def find_by(collection, method, input)
    collection.find {|row| row.send(method) == input}
  end

  def find_all(collection, method, input)
    return find_all_numbers(collection, method, input) if input.is_a? Fixnum
    find_all_strings(collection, method, input)
  end

  def find_all_numbers(collection, method, input)
    collection.find_all {|row| row.send(method) == input }
  end

  def find_all_strings(collection, method, input)
    collection.find_all do |row| 
      row = row.send(method).to_s.downcase
      row.include?(input.downcase)
    end
  end

end
