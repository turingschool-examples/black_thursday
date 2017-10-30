# require 'csv'
require './lib/item'

class ItemRepo

  attr_reader :items

  def initialize
    @items = []
  end
  # attr_reader :parent, :load_repo
  #
  # def initialize(filename, parent)
  #   @parent = parent
  #   @load_repo = load_repo
  # end
  def count
    items.count
  end

  def create_item(data)
    items << Item.new(data, self)
  end

  #
  # def load
  #   # csv.readline(filename headers:true )
  #   # instantiate rows as item.
  #   jafshjafs.each do |row|
  #     Item.new.something(row, self)
  #   end
  # end
  #
  # def merchant(merchant)
  #   @parent.merchant(merchant)
  # end


end
