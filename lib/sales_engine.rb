class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices

  def initialize(merch_item_hash)
    @items = item_creation(merch_item_hash)
    @merchants = merchant_creation(merch_item_hash)
    @invoices = invoice_creation(merch_item_hash)
  end

  def item_creation(merch_item_hash)
    if merch_item_hash[:items].nil?
      nil
    else
      ItemRepository.new(merch_item_hash[:items])
    end
  end

  def merchant_creation(merch_item_hash)
    if merch_item_hash[:merchants].nil?
      nil
    else
      MerchantsRepository.new(merch_item_hash[:merchants])
    end
  end

  def invoice_creation(merch_item_hash)
    if merch_item_hash[:invoices].nil?
      nil
    else
      InvoiceRepository.new(merch_item_hash[:invoices])
    end
  end

  def self.from_csv(item_merch_hash)
    DataRepository.new(item_merch_hash)
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices)
  end
end
