module Calculations
  def diff_and_square(amounts, average)
    amounts.map do |amount|
      (amount - average)**2
    end
  end

  def diff_and_square_sum(amounts, average)
    diff_and_square(amounts, average).sum
  end

  def divide_diff_and_square_sum(amounts, average)
    diff_and_square_sum(amounts, average) / (amounts.length - 1)
  end

  def standard_deviation(amounts, average)
    Math.sqrt(divide_diff_and_square_sum(amounts, average)).round(2)
  end

  def merchants
    @engine.merchants
  end

  def items
    @engine.items
  end

  def invoices
    @engine.invoices
  end

  def average(amount)
    (amount.sum / amount.length.to_f).round(2)
  end
end
