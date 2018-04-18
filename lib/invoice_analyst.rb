module InvoiceAnalyst
    def average_invoices_per_merchant
        invoices = merchants.all.map do |merchant|
            merchant.find_all_by_merchant_id(merchant.id)
        end
        average(invoices)
    end
end