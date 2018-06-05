module DayTable

  def invoice_per_day_table
    {'Sunday' => day_of_week_per_invoice.count('Sunday'),
     'Monday' => day_of_week_per_invoice.count('Monday'),
     'Tuesday' => day_of_week_per_invoice.count('Tuesday'),
     'Wednesday' => day_of_week_per_invoice.count('Wednesday'),
     'Thursday' => day_of_week_per_invoice.count('Thursday'),
     'Friday' => day_of_week_per_invoice.count('Friday'),
     'Saturday' => day_of_week_per_invoice.count('Saturday'),}
  end

  def day_of_week_per_invoice
    @sales_engine.invoices.collection.values.map do |invoice|
      invoice.day_of_week
    end
  end

end
