require './lib/entry'
class SalesEngine

  attr_reader :item_repository,
              :merchant_repository,
              :invoices,
              :invoice_items_repository,
              :customer_repository,
              :transactions_repository

  def initialize(items_path = nil,
                 merchants_path = nil,
                 invoices_path = nil,
                 invoice_items_path = nil,
                 customers_path = nil,
                 transactions_path = nil)

    @item_repository = ItemRepository.new(items_path)
    @merchant_repository = MerchantRepository.new (merchants_path)
    @invoices = InvoicesPath.new (invoices_path)
    @invoice_items_repository = InvoiceItemRepository.new (invoice_items_path)
    @customer_repository = CustomerRepository.new (customers_path)
    @transactions_repository = TransactionRepository.new (transactions_path)
  end

  def self.from_csv(data_hash)
    # SalesEngine.new(data[:items], data[:merchants])
    item_repo_data = CSV.foreach(data_hash[:item_repository], headers: true, header_converters: :symbol) do |row|
      Item.new(
        :id => row[:id].to_i,
        :name => row[:name],
        :description => row[:description].delete("\n"),
        :unit_price => row[:unit_price].to_f,
        :created_at => row[:created_at],
        :updated_at => row[:updated_at],
        :merchant_id => row[:merchant_id].to_i
        )
  end

  def analyst
    SalesAnalyst.new(item_repository, merchant_repository)
  end

end
