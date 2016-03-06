require_relative '../lib/item'
require_relative '../lib/item_repository'


class RepositoryLoaders
  def initialize(sales_engine)
    @sales_engine = sales_engine
  end



  def load_items_into_repository(items_rows)
    items = ItemRepository.new(@sales_engine)
    items_rows.each do |row|
      items.load_item( Item.new(@sales_engine, {:id =>row[:id],
                         :name => row[:name],
                         :description => row[:description],
                         :unit_price => row[:unit_price],
                         :merchant_id => row[:merchant_id],
                         :created_at => row[:created_at],
                         :updated_at => row[:updated_at]}))
    end
    items
  end

  def load_merchants_into_repository(merchants_rows)
    merchants = MerchantRepository.new(@sales_engine)
    merchants_rows.each do |row|
      merchants.repository << Merchant.new(@sales_engine, {:id => row[:id],
                                             :name => row[:name],
                                             :created_at => row[:created_at],
                                             :updated_at => row[:updated_at]})
    end
    merchants
  end

  def load_invoices_into_repository(invoices_rows)
    invoices = InvoiceRepository.new(@sales_engine)
    invoices_rows.each do |row|
      invoices.repository << Invoice.new(@sales_engine, {:id => row[:id],
                                          :customer_id => row[:customer_id],
                                          :merchant_id => row[:merchant_id],
                                          :status => row[:status],
                                          :created_at => row[:created_at],
                                          :updated_at => row[:updated_at]})

    end
    invoices
  end

  def load_invoice_items_into_repository(invoice_items_rows)
    invoice_items = InvoiceItemRepository.new(@sales_engine)
    invoice_items_rows.each do |row|
      @sales_engine.invoice_items.repository << InvoiceItem.new(@sales_engine, {:id => row[:id],
                                          :item_id => row[:item_id],
                                          :invoice_id => row[:invoice_id],
                                          :quantity => row[:quantity],
                                          :unit_price => row[:unit_price],
                                          :created_at => row[:created_at],
                                          :updated_at => row[:updated_at]})

    end
    invoice_items
  end

end
