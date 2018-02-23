require_relative 'searching'

class InvoiceItemRepository
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def find_all_by_item_id(id)
    @all.find_all { |obj| obj.item_id == id }
  end
end
