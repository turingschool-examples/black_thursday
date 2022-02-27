# item_repository
require 'pry'
class ItemRepository
  attr_reader :items

  def initialize(invoices)
    @invoices = invoices
  end

  def all
    @invoices
  end
end
