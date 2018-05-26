require './lib/file_loader'

class SalesEngine
  include FileLoader

  def initialize
    @file_paths = {
                  items:      "./data/items.csv",
                  merchants:  "./data/merchants.csv"
                  }
  end

  def items
    @items ||= open_items_csv(@file_paths[:items])
  end
end
