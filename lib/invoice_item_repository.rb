require_relative 'searching'

class InvoiceItemRepository
  attr_reader :all

  def initialize(file_path)
    @all = 
  end

  def find_all_by_item_id(id)
    @all.find_all { |obj| obj.item_id == id }
    require 'pry'; binding.pry
  end
end
