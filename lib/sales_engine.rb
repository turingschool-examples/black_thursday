require_relative './merchant_repository'
require_relative './item_repository'
require_relative './invoice_repository'
require_relative './invoice'
require_relative './merchant'
require_relative './item'
require_relative './sales_analyst'
require 'CSV'

class SalesEngine
  attr_reader :ir,
              :mr,
              :inv_repo

  def initialize(file_path_hash)
    @mr = MerchantRepository.new(file_path_hash[:merchants])
    @ir = ItemRepository.new(file_path_hash[:items])
    @inv_repo = InvoiceRepository.new(file_path_hash[:invoices])
  end

  def self.from_csv(file_path_hash)
    SalesEngine.new(file_path_hash)
  end

  def merchants
    @mr
  end

  def items
    @ir
  end

  def invoices
    @inv_repo
  end

  def analyst
    sales_analyst = SalesAnalyst.new(@mr, @ir, @inv_repo)
  end

end
