require_relative 'merchant_repository'
require_relative 'item_repository'
require 'csv'

class SalesEngine
  attr_reader :items

  def initialize(input_csv_files)
    @items = ItemRepository.new(input_csv_files[:items])
  end
end
