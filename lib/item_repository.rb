require 'pry'
require 'csv'
require_relative '../lib/item'
require_relative '../lib/file_opener'

class ItemRepository
  include FileOpener
  attr_reader :all_item_data,
              :sales_engine,
              :all

  def initialize(csv_data, sales_engine)
    @sales_engine = sales_engine
    @all_item_data = open_csv(csv_data)
    @all = @all_item_data.map do |row|
      Item.new(row)
    end
    # csv_data[:id] = @all.count
    # @id = csv_data[:id]
  end

end
