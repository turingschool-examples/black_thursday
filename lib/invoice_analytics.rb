require 'pry'
module InvoiceAnalytics

  private

    def total_invoices
      @invoices.id_repo.count.to_f
    end

    def convert_date_to_day(time_object)
      case time_object.wday
      when 1 then "Monday"
      when 2 then "Tuesday"
      when 3 then "Wednesday"
      when 4 then "Thursday"
      when 5 then "Friday"
      when 6 then "Saturday"
      when 0 then "Sunday"
      end
    end

    def invoices_by_day
      @invoices.id_repo.values.reduce({"Monday" => [],
                                       "Tuesday" => [],
                                       "Wednesday" => [],
                                       "Thursday" => [],
                                       "Friday" => [],
                                       "Saturday" => [],
                                       "Sunday" =>[]}) do |result_hash, invoice_object|
        object_day = convert_date_to_day(invoice_object.created_at)
        result_hash[object_day] << invoice_object
        result_hash
      end
    end

  public

    def average_invoices_per_day
      (total_invoices / 7.0).round(2)
    end

    def average_invoices_per_merchant
      (total_invoices / total_merchants).round(2)
    end

    def average_invoices_per_merchant_standard_deviation
      merchant_invoices = Proc.new {|merchant| merchant.invoices.count}
      standard_deviation(average_invoices_per_merchant, @merchants.id_repo, merchant_invoices, total_merchants)
    end

    def average_invoices_per_day_standard_deviation
      summed = invoices_by_day.values.reduce(0) do |sum, invoices_on_this_day|
        sum += (invoices_on_this_day.count - average_invoices_per_day) ** 2
      end
      divided_result = summed / (total_invoices - 1)
      Math.sqrt(divided_result).round(2)
    end

    def top_merchants_by_invoice_count
      two_stndv_above_avg = (average_invoices_per_merchant_standard_deviation * 2) + average_invoices_per_merchant
      @merchants.id_repo.keys.reduce([]) do |results, id|
        if @merchants.id_repo[id].invoices.count >= two_stndv_above_avg
          results << @merchants.id_repo[id]
        end
        results.flatten
      end
    end

    def bottom_merchants_by_invoice_count
      two_stndv_below_avg = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
      @merchants.id_repo.keys.reduce([]) do |results, id|
        if @merchants.id_repo[id].invoices.count <= two_stndv_below_avg
          results << @merchants.id_repo[id]
        end
        results.flatten
      end
    end

    def top_days_by_invoice_count
      two_stndv_above_avg = average_invoices_per_day_standard_deviation + average_invoices_per_day
      top_days = invoices_by_day.keys.find_all do |day|
        invoices_by_day[day].count >= two_stndv_above_avg
      end
      top_days.map {|day| day.to_sym }
    end

    def invoice_status(symbol_marker)
      number_of = @invoices.id_repo.values.find_all do |invoice|
        invoice.status == symbol_marker.to_s
      end
      ((number_of.count / total_invoices) * 100).round(2)
    end

    def merchants_with_pending_invoices
      @merchants.id_repo.values.find_all do |merchant|
        merchant.invoices.any? do |invoice|
          invoice.status == "pending"
        end
      end
    end
end
