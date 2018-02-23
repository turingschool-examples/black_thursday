require_relative 'searching'

class InvoiceItemRepository
  include Searching
  attr_reader :all

  def initialize(file_path)
    @all = from_csv(file_path)
  end

  def add_elements(data)
    data.map { |row| InvoiceItem.new(row) }
  end

  def find_all_by_item_id(id)
    @all.find_all { |obj| obj.item_id == id }
  end
end
