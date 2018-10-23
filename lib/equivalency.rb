module Equivalency
  def ==(other)
    return false unless self.class == other.class
    self.instance_variables.each do |var|
      var = var.to_s[1..-1]
      return false unless self.send(var).to_s == other.send(var).to_s
    end
    true
  end
end
