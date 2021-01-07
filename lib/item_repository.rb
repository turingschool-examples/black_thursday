require 'pry'
require 'csv'
# require_relative './item'
require_relative './merchant'

class ItemRepository
  attr_reader :all,
              :engine

  def initialize(items_path, engine)
    @all = []
    @engine = engine

    # CSV.foreach(items_path, headers: true, header_converters: :symbol) do |row|
    #   @all << convert_to_merchant(row)
    # end
  end

  def convert_to_merchant(row)
    row = Merchant.new({id: row[:id], name: row[:name], created_at: row[:created_at], updated_at: row[:updated_at]})
  end
end
