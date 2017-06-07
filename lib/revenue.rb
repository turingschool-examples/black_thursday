require 'pry'


class Revenue
  attr_reader :parent,
              :revenue_by_date,
              :revenue_by_merchant_id

  def initialize(parent)
    @parent = parent
    @revenue_by_date = {}
    @revenue_by_merchant_id = {}
    @start = extract_date_and_revenue; extract_merchants_and_revenues
  end

  def extract_date_and_revenue
    access_invoice_items.values.each do |v|
      a = date_convert(v.created_at)
      b = v.unit_price * v.quantity
      if revenue_by_date.has_key?(v.created_at)
        @revenue_by_date[a] += (v.unit_price * v.quantity)
      else
        @revenue_by_date[a] = b
      end
    end
  end

  def extract_merchants_and_revenues
    invoice_id_and_sales = {}
    a = access_invoice_items.values.each do |v|
      a = v.invoice_id
      b = v.unit_price * v.quantity
      if invoice_id_and_sales.has_key?(v.invoice_id)
        invoice_id_and_sales[a] += (v.unit_price * v.quantity)
      else
        invoice_id_and_sales[a] = b
      end
    end
    replace_invoice_id_with_merchant_id(invoice_id_and_sales)
  end

  def replace_invoice_id_with_merchant_id(hash)
    hash.each do |k,v|
      a = invoice_to_merchant_conversion(k)
      @revenue_by_merchant_id[a] = v
      # binding.pry
    end
  end

  def merchant_revenue
    a = @revenue_by_merchant_id
    b = a.invert.to_a
    b.sort!
    b.reverse!
    c = b.transpose
    d = c[1]
  end

private

  def date_convert(date)
   date.strftime "%Y-%m-%d"
  end

  def access_invoice_items
    @parent.parent.invoice_items.contents
  end

  def access_invoices
    @parent.parent.invoices.contents
  end

  def invoice_to_merchant_conversion(inv)
    access_invoices.values.each do |v|
      if v.id == inv
        return v.merchant_id
      end
    end
  end
end
