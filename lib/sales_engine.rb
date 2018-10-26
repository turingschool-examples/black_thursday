require_relative './merchant_repository'
require_relative './item_repository'
require_relative './sales_analyst'


class SalesEngine
  attr_reader :merchants, :items

  def initialize(merch_repo, item_repo, invoice_item_repo)
    @merchants         = merch_repo
    @items             = item_repo
    @invoice_item_repo = invoice_item_repo
  end

  def self.from_csv(csv_data_paths)
    merch_repo        = MerchantRepository.new(csv_data_paths[:merchants])
    item_repo         = ItemRepository.new(csv_data_paths[:items])
    invoice_item_repo = InvoiceItemRepository.new(csv_data_paths[:invoiceitems])
    self.new(merch_repo, item_repo, invoice_item_repo)
  end

  def analyst
    SalesAnalyst.new(@merchants, @items)
  end

end
