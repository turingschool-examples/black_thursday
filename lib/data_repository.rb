# frozen_string_literal: true

# DataRepository class creates instances of merchant, item, and invoice repos

class DataRepository
  attr_reader :merchants,
              :items,
              :invoices

  def initialize(data_hash)
    @merchants = merchant_repo(data_hash)
    @items = item_repo(data_hash)
    @invoices = invoice_repo(data_hash)
  end

  def merchant_repo(data_hash)
    if data_hash[:merchants].nil?
      nil
    else
      MerchantsRepository.new(data_hash[:merchants])
    end
  end

  def item_repo(data_hash)
    if data_hash[:items].nil?
      nil
    else
      ItemRepository.new(data_hash[:items])
    end
  end

  def invoice_repo(data_hash)
    if data_hash[:invoices].nil?
      nil
    else
      InvoiceRepository.new(data_hash[:invoices])
    end
  end
end
