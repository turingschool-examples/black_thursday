module SalesRelationships
    def find_all_items_by_merchant_id(merchant_id)
        item_repo.find_all_by_merchant_id(merchant_id)
    end

    def find_all_invoices_by_merchant_id(merchant_id)
        invoice_repo.find_all_by_merchant_id(merchant_id)
    end
end