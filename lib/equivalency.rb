module Equivalency
  def ==(other)
    return false unless self.class == other.class
    self.instance_variables.each do |var|
      var = var.to_s[1..-1]
      return false unless self.send(var) == other.send(var)
    end
    true
  end
end
