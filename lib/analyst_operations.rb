module AnalystOperations

 def average(collection)
    if empty collection
      0
    elsif single collection
      single_operator collection
    else
      big collection
    end
  end

  def status_average_operator(status)
    matches = invoices.find_all do |invoice|
      invoice.id if invoice.status.eql?(status)
    end
    status_average_formatter(matches)
  end

  def status_average_formatter(matches)
    ((matches.size.to_f / invoices.size.to_f) * 100).to_s
  end

  def single_operator(collection)
    collection[0].to_f
  end

  def price_average_operator(id)
    average(price_compiler(id)).to_s
  end

  def average_average_operator
    averages = merchants.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
    @average_average = decimal(average(averages).to_s).round(2)
  end

end