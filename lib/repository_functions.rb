module RepositoryFunctions

  def self.find_by(variable, input)
    variable[input]

  end


  def self.find_all(variable, input)
    found = []
    variable.select do |name, row|
      found <<  name if row.include?(input)
    end
    found
  end
end
