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
    days
  end



end
