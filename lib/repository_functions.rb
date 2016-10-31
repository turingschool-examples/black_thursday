module RepositoryFunctions

  def self.find_by(variable, input)
    variable.find {|name| name == input}
  end


  def self.find_all(variable, input)
   variable.find_all {|name| name == input}
  end
end
