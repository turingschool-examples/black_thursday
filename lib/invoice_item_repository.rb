require_relative 'invoice_item'

class InvoiceItemRepository

    attr_reader     :all,
                    :sales_engine

    def initialize(parent = nil)
      @all          = []
      @sales_engine = parent
    end

    def inspect
     "#<#{self.class} #{@all.size} rows>"
    end

    def populate(filename)
      CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
        @all << InvoiceItem.new(row, self)
      end
    end

    def find_by_id(id)
      @all.find do |invoice_item|
        invoice_item.id == id
      end
    end

    def find_all_by_item_id(item_id)
      @all.find_all do |invoice_item|
        invoice_item.item_id == item_id
      end
    end

    def find_all_by_invoice_id(invoice_id)
      @all.find_all do |invoice_item|
        invoice_item.invoice_id == invoice_id
      end
    end

end
