require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'

class SalesEngine

  def self.from_csv(files)
    @merchant_repo = create_merchant_repository(files)
    @item_repo = create_item_repository(files)
    @invoice_repo = create_invoice_repository(files)
    self
  end

  def self.create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(files[:items], self)
    end
  end

  def self.items
    @item_repo
  end

  def self.create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(files[:merchants], self)
    end
  end

  def self.merchants
    @merchant_repo
  end

  def self.create_invoice_repository(files)
    if files.include?(:invoices)
      InvoiceRepository.new(files[:invoices], self)
    end
  end

  def self.invoices
    @invoice_repo
  end

  def self.find_by_merchant_id(merchant_id)
    merchants.find_by_id(merchant_id)
  end

  def self.find_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end

end