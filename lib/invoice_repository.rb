require_relative 'module'
class InvoiceRepository
  include IDManager
  def initialize(info)
    @all = info
  end

  def find_all_by_status(search)
    @all.find_all{|index| index.status == search}
  end

  def find_all_by_merchant_id(search)
    @all.find_all{|index| index.merchant_id == search}
  end

  def find_all_by_customer_id(search)
    @all.find_all{|index| index.customer_id == search}
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end
