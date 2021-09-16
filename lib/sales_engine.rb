require 'csv'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions

  def self.from_csv(paths)
    # fix these names to make them more clear
    ip         = paths[:items]
    mp     = paths[:merchants]
    inp      = paths[:invoices]
    iip = paths[:invoice_items]
    tp  = paths[:transactions]
    cp     = paths[:customers]

    SalesEngine.new(ip, mp, inp, iip, tp, cp)
  end

  def initialize(ip, mp, inp, iip, tp, cp)
    # @customer_repository = CustomerRepository.new(@customer_path)
    @transactions = TransactionRepository.new(tp)
    @invoice_items = InvoiceItemRepository.new(iip)
    @invoices = InvoiceRepository.new(inp)
    @items = ItemRepository.new(ip)
    @merchants = MerchantRepository.new(mp)
  end
end
