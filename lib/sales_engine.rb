require 'csv'
require_relative 'sales_analyst'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'invoice_repository'
require_relative 'transaction_repository'
require_relative 'invoice_item_repository'
require_relative 'customer_repository'


class SalesEngine
  attr_reader   :items,
                :merchants,
                :invoices,
                :transactions,
                :invoice_items,
                :customers

  def csv_to_hash(path)
    raw_input = CSV.open(path, headers: true, header_converters: :symbol)
    raw_input.map do | pre_hash |
      pre_hash.to_h
    end
  end

  def hashes_to_repos(hashes, blank_repo)
    hashes.each do | hash |
      blank_repo.create(hash)
    end
  end

  def create_repos(paths)
    item_hashes = csv_to_hash(paths[:items])
    @items = ItemRepository.new
    hashes_to_repos(item_hashes, @items)

    merchant_hashes = csv_to_hash(paths[:merchants])
    @merchants = MerchantRepository.new
    hashes_to_repos(merchant_hashes, @merchants)

    invoice_hashes = csv_to_hash(paths[:invoices])
    @invoices = InvoiceRepository.new
    hashes_to_repos(invoice_hashes, @invoices)

    transaction_hashes = csv_to_hash(paths[:transactions])
    @transactions = TransactionRepository.new
    hashes_to_repos(transaction_hashes, @transactions)

    invoice_item_hashes = csv_to_hash(paths[:invoice_items])
    @invoice_items = InvoiceItemRepository.new
    hashes_to_repos(invoice_item_hashes, @invoice_items)

    customer_hashes = csv_to_hash(paths[:customers])
    @customers = CustomerRepository.new
    hashes_to_repos(customer_hashes, @customers)
  end

  def self.from_csv(paths)
    se = SalesEngine.new
    se.create_repos(paths)
    se
  end

  def analyst
    SalesAnalyst.new(@items, @merchants, @invoices, @transactions, @invoice_items, @customers)
  end
end
