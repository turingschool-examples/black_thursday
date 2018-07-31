# frozen_string_literal: true

class InvoiceAnalyst
  def initialize(invoice_repository)
    @invoice_repo = invoice_repository
  end

  def group_invoices_by_merchant_id
    @invoice_repo.all.group_by { |invoice| invoice.merchant_id }
  end

  def number_of_merchants
    group_invoices_by_merchant_id.keys.count
  end

  def average_invoices_per_merchant
    (@invoice_repo.all.size / number_of_merchants.to_f).round(2)
  end

  def average_invoices_per_day
    (@invoice_repo.all.size / 7.0).round(2)
  end

  def group_by_day
    @invoice_repo.all.group_by do |invoice|
      Time.parse(invoice.created_string).strftime('%A')
    end
  end

  def percent_by_invoice_status(status)
    grouped_by_status = @invoice_repo.all.group_by(&:status)
    percent = grouped_by_status[status].size.to_f / @invoice_repo.all.size 
    (percent * 100).round(2)
  end



end
