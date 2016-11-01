module RepositoryFunctions

  def find_by(variable, method, input)
    variable.find {|row| row.send(method) == input}
  end

  def find_all(variable, method, input)
    variable.find_all do |row| 
      row = row.send(method).to_s.downcase
      row.include?(input.downcase)
    end
  end

end
