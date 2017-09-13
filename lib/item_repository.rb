require_relative 'item'
require 'csv'

class ItemRepository

  attr_reader :all

  def initialize(se, item_csv)
    @all = []
    @se = se
    CSV.foreach(item_csv, headers: true, header_converters: :symbol) do |row|
      @all << Item.load_csv(row)
    end
  end



end
