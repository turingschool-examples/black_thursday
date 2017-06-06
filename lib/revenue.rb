require 'pry'


class Revenue
  attr_reader :parent,
              :revenue_by_date,
              :revenue_by_merchants

  def initialize(parent)
    @parent = parent
    @revenue_by_date = {}
    @revenue_by_merchants = {}
    @start = extract_date_and_revenue
  end

  def access_invoice_items
    @parent.parent.invoice_items.contents
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

  def date_convert(date)
   date.strftime "%Y-%m-%d"
  end

end
