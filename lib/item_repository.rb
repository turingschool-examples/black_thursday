require 'csv'
require 'pry'
require_relative 'item'

class ItemsRepository

  def initialize(item_csv_data, engine ="")
    @all = []
    create_item_instances(item_csv_data)
    @engine = engine
  end

  def create_item_instances(data)
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      all << Item.new({id: row[:id], name: row[:name], description: row[:description], unit_price: row[:unit_price]}, engine)
      end
   end

end
