module InvoiceAssistant
  def invoices_by_day
    @invoices.members.group_by do |invoice|
      invoice.created_at.strftime('%A')
    end
  end

  def total_invoices_per_day
    invoices_by_day.values.map do |day|
      day.count
    end
  end

  def invoices_by_merchant_id
    invoices_per_merchant = Hash.new(0)
    @invoices.members.each do | invoice |
      invoices_per_merchant[invoice.merchant_id] += 1
    end
    invoices_per_merchant
  end

  def merchant_ids_with_more_invoices_than_two_standard_deviations_above_average
    higher_than = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    ids = invoices_by_merchant_id.keys.map do | merchant |
      if invoices_by_merchant_id[merchant] > higher_than
        merchant
      end
    end.compact
  end

  def merchant_ids_with_less_invoices_than_two_standard_deviations_below_average
    lower_than = average_invoices_per_merchant - (average_invoices_per_merchant_standard_deviation * 2)
    ids = invoices_by_merchant_id.keys.map do | merchant |
      if invoices_by_merchant_id[merchant] < lower_than
        merchant
      end
    end.compact
  end
end
