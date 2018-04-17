module InvoiceItemHelper
  def find_all_by_item_id(ii)
    @repository.values.find_all do |invoice_item|
      invoice_item.item_id == ii
    end
  end

  def find_all_by_invoice_id(ii)
    @repository.values.find_all do |invoice_item|
      invoice_item.invoice_id == ii
    end
  end

end
