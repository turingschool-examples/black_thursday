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

    def top_merchants_by_invoice_count
        invoices = invoices_per_merchant
        average = average_invoices_per_merchant
        std = standard_deviation(invoices, average)
        merchants.all.find_all do |merchant|
            by_deviation(merchant.invoices.length, average, std, 2)
        end
    end

    def bottom_merchants_by_invoice_count
        invoices = invoices_per_merchant
        average = average_invoices_per_merchant
        std = standard_deviation(invoices, average)
        merchants.all.find_all do |merchant|
            by_deviation(merchant.invoices.length, average, std, -2)
        end
    end

    def find_all_invoices_by_date
        invoice_dates = invoices.all map do |invoice|
            invoice.created_at
        end

        invoice_dates.map do |invoice_date|
            invoice_dates.count(invoice_date)
            by_deviation()
        end

        
    end

    def top_days_by_invoice_count
        invoice_dates = invoices.all.map do |invoice|
            invoice.created_at
        end
        average = average(invoice_dates)
        std = standard_deviation(invoice_date, average)

        a = invoice_dates.map do |invoice_date|
            invoices_per_day = invoice_dates.count(invoice_date)
            by_deviation(invoices_per_day, average, std, 1)
        end
        binding.pry
        return a
    end
end