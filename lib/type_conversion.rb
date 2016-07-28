module TypeConversion

  def convert_to_big_decimal(unit_price)
    if unit_price.is_a?(String)
      BigDecimal.new(unit_price.to_f/100, 0).round(2)
    elsif unit_price.is_a?(Integer)
      BigDecimal.new(unit_price.to_f/100, 0).round(2)
    elsif unit_price.is_a?(BigDecimal)
      unit_price
    end
  end

  def convert_to_integer(unit_price)
    unit_price.to_i * 100
  end

end
