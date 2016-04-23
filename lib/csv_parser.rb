require 'csv'

class CsvParser

  def merchants(merchants)
    contents = CSV.open merchants, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end


  def items(items)
    contents = CSV.open items, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end

  def invoices(invoices)
    contents = CSV.open invoices, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end

  def invoice_items(invoice_items)
    contents = CSV.open invoice_items, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end

  def transactions(transactions)
    contents = CSV.open transactions, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end

  def customers(customers)
    contents = CSV.open customers, headers: true, header_converters: :symbol
    contents.map do |row|
      row.to_h
    end
  end

end
