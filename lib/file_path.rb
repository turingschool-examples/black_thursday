module FilePath
    def parse_data(file)
        rows = CSV.open hash_path[:invoice_items], headers: true, header_converters: :symbol
        rows.each do |row|
            require 'pry'; binding.pry
          new_item = InvoiceItem.new(row.to_h)
          sales_engine.invoice_items.all << new_item
        end  
      end
end