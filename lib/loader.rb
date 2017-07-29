module Loader

  def load_merchants(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def load_items(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def load_invoices(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def load_invoice_items(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def load_transactions(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

  def load_customers(csvfile)
    CSV.open csvfile, headers: true, header_converters: :symbol
  end

end
