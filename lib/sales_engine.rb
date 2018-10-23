require 'csv'
require 'Time'

require_relative 'merchant_repository'
require_relative 'item_repository'

require 'pry'

class SalesEngine
  attr_reader :items, :merchants
  def initialize(item_repository, merchant_repository)
    @items = item_repository
    @merchants = merchant_repository
  end

  def self.from_csv(file_hash)
    items_file = CSV.read(file_hash[:items], headers: true, header_converters: :symbol)
    merchants_file = CSV.read(file_hash[:merchants], headers: true, header_converters: :symbol)
    item_repository = ItemRepository.new
    merchant_repository = MerchantRepository.new

    merchants_file.each do |row|
      # binding.pry
      merchant_repository.create(build_merchant_args_from_row(row))
    end

    items_file.each do |row|
      # binding.pry
      item_repository.create(build_item_args_from_row(row))
    end
    self.new(item_repository, merchant_repository)
  end

  def self.build_item_args_from_row(row)
    {
      :id          => row[:id].to_i,
      :name        => row[:name],
      :description => row[:description],
      :unit_price  => BigDecimal.new(row[:unit_price],4),
      :created_at  => Time.parse(row[:created_at]),
      :updated_at  => Time.parse(row[:updated_at]),
      :merchant_id => row[:merchant_id].to_i
      }
  end

  def self.build_merchant_args_from_row(row)
    {
      id: row[:id].to_i,
      name: row[:name]
    }
  end
end
