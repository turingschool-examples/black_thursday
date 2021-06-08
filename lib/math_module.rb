module MathModule

  def standard_dev(nums, average)
    total_sum = nums.sum {|nums| (nums - average) **2 }
    std_dev = Math.sqrt(total_sum / (nums.length - 1).to_f).round(2)
  end

  def invoices_per_day_of_the_week
    days_of_the_week = {}
    engine.invoices.all.each do |invoice|
      days_of_the_week[wday] = invoice.created_at
    end
    days_of_the_week
    require "pry"; binding.pry
  end
end
