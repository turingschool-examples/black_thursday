require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require "csv"


class SalesEngine

  def self.from_csv(filenames)
    options = { headers: true, header_converters: :symbol }
    tables = filenames.transform_values do |filename|
      CSV.foreach(filename, options).map do |row|
        row.to_hash
      end
    end
    new(tables)
  end

  def initialize(data)
    @repos = data.each_with_object({}) do |(type, data), repos|
      repos[type] = repo_subclasses[type].new(self, data)
    end
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

private

  def repo_subclasses
    {
      items: ItemRepository,
      merchants: MerchantRepository,
      invoices: InvoiceRepository
    }
  end

end
