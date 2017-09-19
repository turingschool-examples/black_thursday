module UnitPrice

  def unit_price_to_dollars(unit_price_in_cents)
    dollars = unit_price_in_cents.to_f / 100
    BigDecimal.new(dollars, 5)
  end

end
