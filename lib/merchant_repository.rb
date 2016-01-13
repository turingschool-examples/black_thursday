require 'csv'
require_relative 'merchant'
require_relative 'item_repository'

class MerchantRepository
attr_reader :data, :all, :merchant_file, :item_repository, :merchant, :repo

  def inspect
      "#<#{self.class} #{@all_merchants.size} rows>"
  end

  def initialize(merchant_file)
    @all = []
    @merchant_file = merchant_file
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
              :name => name,
              :created_at => created_at,
              :updated_at => updated_at}
      @merchant = Merchant.new(hash)
      @all << merchant
    #  assign_merchant_item(merchant)
    end
  end
  #
  # def assign_merchant_item(merchant)
  #   merchant.item = repo.items.find_all_by_merchant_id(merchant.id)
  # end

  def find_by_id(number)
    all.find do |x|
      x.id == number
    end
  end

  def find_by_name(name)
    all.find do |x|
      x.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all.find_all do |x|
      x.name.downcase == name.downcase
    end
  end
end
