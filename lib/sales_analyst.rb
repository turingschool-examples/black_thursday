require "./lib/sales_engine"
require "./lib/calculator"
require "./lib/merchant_analyst"
require "./lib/item_analyst"
require "./lib/invoice_analyst"

class SalesAnalyst
    include Calculator
    include MerchantAnalyst
    include ItemAnalyst
    include InvoiceAnalyst

    attr_reader :sales_engine

    def initialize(sales_engine)
        @sales_engine = sales_engine
    end

    def items
        @sales_engine.item_repo
    end

    def merchants
        @sales_engine.merchant_repo
    end

    def invoices
        @sales_engine.invoice_repo
    end
end
