module Sanitize
  def to_price(price)
    p = BigDecimal(price, 4)
    p = (p / 100) if (p % 1).zero?
    p
  end

  def to_time(time)
    # require 'pry'; binding.pry
    Time.new(time.to_s)
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end