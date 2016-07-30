require_relative '../lib/statistics'
require 'pry'
class InvoiceAnalyst

  include Statistics

  def initialize(all_invoices)
    @all_invoices = all_invoices
  end

  def invoices_per_day
    yup = @all_invoices.reduce(Array.new(7) {0}) do |days, invoice|
      days[invoice.created_at.wday] += 1
      days
    end
  end

  def top_days_by_invoice_count
    avg = mean(invoices_per_day)
    std_dev = standard_deviation(invoices_per_day)
    invoices_per_day.reduce([]) do |top_days, day|
      if day > (avg + std_dev)
        top_days << day_of_week(invoices_per_day.index(day))
      end
      top_days
    end
  end

  def day_of_week(index)
    days =
    {0 => "Sunday",
     1 => "Monday",
     2 => "Tuesday",
     3 => "Wednesday",
     4 => "Thursday",
     5 => "Friday",
     6 => "Saturday"}
     days[index]
   end

   def invoice_status(status_to_find)
     matching_invoices = @all_invoices.find_all do |invoice|
       invoice.status == status_to_find
     end
     ((matching_invoices.length.to_f / @all_invoices.length) * 100).round(2)
   end

end
