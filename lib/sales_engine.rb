require_relative 'file_loader.rb'
require_relative 'merchant_repository.rb'
require_relative 'item_repository.rb'
require_relative 'sales_analyst.rb'
require_relative 'invoice_repository.rb'

class SalesEngine
  include FileLoader
  attr_reader :content

  def initialize(content)
    @content = content
  end

  def self.from_csv(content)
    new(content)
  end

  def items
    @items ||= ItemRepository.new(load_file(content[:items]))
  end

  def merchants
    @merchants ||= MerchantRepository.new(load_file(content[:merchants]))
  end

  def analyst
    @analyst = SalesAnalyst.new(self)
  end

  def invoices
    @invoices ||= InvoiceRepository.new(load_file(content[:invoices]))
  end

end
