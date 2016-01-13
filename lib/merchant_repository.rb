require 'csv'
require_relative 'merchant'
require_relative 'item_repository'

class MerchantRepository
attr_reader :data, :all_merchants, :merchant_file, :item_repository, :items_file

  def initialize(merchant_file, items_file)
    @item_repository = ItemRepository.new(items_file)
    @all_merchants = []
    @merchant_file = merchant_file
    @items_file = items_file
    data_into_hash(load_data(merchant_file))
  end

  def load_data(merchant_file)
    @data = CSV.open (merchant_file), headers: true, header_converters:
    :symbol
  end

  def data_into_hash(data)
    data.each do |row|
      merchant_id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      hash = {:id => merchant_id,
              :name => name, :created_at => created_at, :updated_at => updated_at}
      merchant = Merchant.new(hash)
      merchant.item = @item_repository.find_all_by_merchant_id(merchant.id)
      @all_merchants << merchant
    end
  end

  def find_by_id(number)
    all_merchants.find do |x|
      x.id == number
    end
  end

  def find_by_name(name)
    all_merchants.find do |x|
      x.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all_merchants.find_all do |x|
      x.name.downcase == name.downcase
    end
  end
end
