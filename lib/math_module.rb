require 'Date'

module MathModule

  def standard_dev(nums, average)
    total_sum = nums.sum {|nums| (nums - average) **2 }
    std_dev = Math.sqrt(total_sum / (nums.length - 1).to_f).round(2)
  end

  def invoices_for_weekdays
    weekdays = []
    @engine.invoices.all.each do |invoice|
      weekdays << invoice.created_at.wday
    end
    weekdays
  end

  def invoices_per_day_of_the_week
    days_of_the_week = {}
    @engine.invoices.all.each do |invoice|
      count = invoices_for_weekdays.count do |weekday|
        invoice.created_at.wday == weekday
      end
      days_of_the_week[invoice.created_at.wday] = count
  end
    days_of_the_week
  end

  def average_invoices_per_weekday
    (invoices_per_day_of_the_week.values.sum / invoices_per_day_of_the_week.values.length)
  end

  def average_invoices_per_weekday_standard_deviation
    x = average_invoices_per_weekday
    values = invoices_per_day_of_the_week.values
    standard_dev(values, x)
  end

  def tranform_weekday_values(collection)
    collection.map do |day|
       Date::DAYNAMES[day]
     end
  end
end
