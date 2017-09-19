require "date"

module MerchantTopDaysByInvoiceCount

  def date_from_invoices
    sales_engine.invoices.all.map do |invoice|
      invoice.created_at.strftime("%Y,%-m,%-d")
    end
  end

  def invoice_id_with_date
    #need hash with invoice_id: date, eventually subbing date with wday.
    invoice_with_date = Hash.new
    sales_engine.invoices.all.map do |invoice|
      invoice_with_date[invoice.id] = invoice.created_at.strftime("%Y,%-m,%-d")
    # invoice_with_date looks like this {2402=>"2006,6,27", ...}
    end
    invoice_with_date.each do |key, value|
      # binding.pry
      invoice_with_date[key] = value.split(",")
      #ok. {1=>["2009", "2", "7"], ...}
    end
    invoice_with_date.each do |key, value|
      invoice_with_date[key] = value.map! {|num| num.to_i}
      #ok.{1=>[2009, 2, 7], ...]
    end
    invoice_with_date.each do |key, value|
      invoice_with_date[key] = Date.new(value[0], value[1], value[2]).wday
      # VICTORYYYYYYYY {1=>6, 2=>5, 3=>3,...}
    end
  end

  def average_invoices_per_day
    # num invoices / num days
    sales_engine.invoices.all.count / 7
  end

  def invoices_per_day #works
    days = Hash.new(0)
    invoice_id_with_date.each do |key, value|
      days[value] += 1
    end
    days  #{6=>348, 5=>322, 3=>364, 1=>344, 0=>351, 2=>316, 4=>357}
  end

  def top_day_numerator
    numerator = 0
    invoices_per_day.each do |wday, invoices|
      numerator += ((invoices - average_invoices_per_day)**2)
    end
    numerator #1897
  end

  def top_day_denominator
    average_invoices_per_day - 1
  end # 342

  def top_day_standard_deviation
    Math.sqrt(top_day_numerator / top_day_denominator)
  end #2.23606797749979

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
