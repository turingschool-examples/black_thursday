class BusinessData
  def ==(other)
    return false unless self.class == other.class
    self.instance_variables.each do |var|
      var = var.to_s[1..-1]
      return false unless self.send(var).to_s == other.send(var).to_s
    end
    true
  end

  def unit_price_to_dollars
    unit_price.round(2).to_f
  end
end
