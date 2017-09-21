require "date"

module TopDaysByInvoiceCount

  def date_from_invoices
    sales_engine.invoices.all.map do |invoice|
      invoice.created_at.strftime("%Y,%-m,%-d")
    end
  end

  def invoice_id_with_date
    invoice_with_date = Hash.new
    sales_engine.invoices.all.map do |invoice|
      invoice_with_date[invoice.id] = invoice.created_at.strftime("%Y,%-m,%-d")
    end
    invoice_with_date.each do |key, value|
      invoice_with_date[key] = value.split(",")
    end
    invoice_with_date.each do |key, value|
      invoice_with_date[key] = value.map! {|num| num.to_i}
    end
    invoice_with_date.each do |invoice_id, date|
      invoice_with_date[invoice_id] = Date.new(date[0], date[1], date[2]).wday
    end
  end

  def average_invoices_per_day
    sales_engine.invoices.all.count / 7
  end

  def invoices_per_day
    days = Hash.new(0)
    invoice_id_with_date.each do |key, value|
      days[value] += 1
    end
    days
  end

  def top_day_numerator
    numerator = 0
    invoices_per_day.each do |wday, invoices|
      numerator += ((invoices - average_invoices_per_day)**2)
    end
    numerator
  end

  def top_day_denominator
    6
  end

  def top_day_standard_deviation
    Math.sqrt(top_day_numerator / top_day_denominator)
  end

  def find_top_days
    top_days = []
    invoices_per_day.each do |wday, invoices|
      if invoices > (average_invoices_per_day + top_day_standard_deviation)
        top_days << wday
      end
    end
    top_days
  end

  def convert_numbers_to_weekdays
    top_days = find_top_days.map do |day|
      if day == 0
        day = "Sunday"
      elsif day == 1
        day = "Monday"
      elsif day == 2
        day = "Tuesday"
      elsif day == 3
        day = "Wednesday"
      elsif day == 4
        day = "Thursday"
      elsif day == 5
        day = "Friday"
      elsif day == 6
        day = "Saturday"
      end
    end
    top_days
  end

end
