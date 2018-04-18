module InvoiceAnalyst
    def invoices_per_merchant
        invoices = merchants.all.map do |merchant|
            merchant.invoices.length
        end
    end

    def average_invoices_per_merchant
        invoices = invoices_per_merchant
        average(invoices)
    end

    def average_invoices_per_merchant_standard_deviation
        invoices = invoices_per_merchant
        average = average_invoices_per_merchant
        standard_deviation(invoices, average)
    end
end