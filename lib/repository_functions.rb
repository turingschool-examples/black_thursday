module RepositoryFunctions

  def find_by(variable, method, input)
    variable.find {|row| row.send(method) == input}
  end

  def find_all(variable, method, input)
    return variable.find_all {|row| row.send(method) == input } if method == :unit_price || method == :merchant_id
    variable.find_all do |row| 
      row = row.send(method).to_s.downcase
      row.include?(input.downcase)
    end
  end

end
