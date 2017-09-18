require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
# require_relative 'customer_repository'
# require_relative 'transaction_repository'
require "csv"


class SalesEngine

  def self.from_csv(filenames)
    new(parse_csv(filenames))
  end

  def self.parse_csv(filenames)
    options = { headers: true, header_converters: :symbol }
    tables = filenames.transform_values do |filename|
      CSV.foreach(filename, options).map do |row|
        row.to_hash
      end
    end
  end

  def initialize(record_data)
    @repos = repo_subclasses.each_with_object({}) do |(type, repo_class), repos|
      repos[type] = repo_class.new(self, record_data[type])
    end
  end

  def repo_subclasses
    {
      items: ItemRepository,
      merchants: MerchantRepository,
      invoices: InvoiceRepository,
      # customers: CustomerRepository,
      # transactions: TransactionRepository,
      invoice_items: InvoiceItemRepository
    }
  end

  def repo(type)
    @repos[type]
  end

  def merchants
    repo :merchants
  end

  def items
    repo :items
  end

  def invoices
    repo :invoices
  end

  def invoice_items
    repo :invoice_items
  end

  def transactions
    repo :transactions
  end

  def customers
    repo :customers
  end

end
