class InvoiceItemRepository
  def initialize
 |row| InvoiceItem.new(row, self) }
  end

  def from_csv(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

end
