module MathModule

  def invoices_per_day_of_the_week
    days_of_the_week = {}
    engine.invoices.all.each do |invoice|
      days_of_the_week[invoice] = invoice.created_at.wday
    end
    days_of_the_week
    require "pry"; binding.pry
  end
end
