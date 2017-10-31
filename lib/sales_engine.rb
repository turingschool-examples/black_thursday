require 'csv'
require './lib/item_repository'

class SalesEngine
  attr_reader :item_repository, :merchant_repository

  def initialize
    @item_repository = nil
    @merchant_repository = nil
  end

  def from_csv(files)
    @item_repository = ItemRepository.new(load(files[:items]))
    @merchant_repository = MerchantRepository.new(load(files[:merchants]))
  end

  #module candidate w/ cleanup
  def load(file_name)
    data = CSV.open(file_name, headers: true, header_converters: :symbol)
    data.map do |row|
      row
    end
  end

end
