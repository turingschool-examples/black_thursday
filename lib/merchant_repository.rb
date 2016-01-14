require 'merchant'
require './lib/csv_loader'

class MerchantRepository
include CsvLoader

attr_reader  :all, :item_repository, :merchant

  def inspect
    "#<#{self.class} #{@all_merchants.size} rows>"
  end

  def initialize(merchant_file)
    data_into_hash(load_data(merchant_file))
  end

  def data_into_hash(data)
    @all ||= data.map do |row|
      merchant_id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      hash = {:id => merchant_id,
              :name => name,
              :created_at => created_at,
              :updated_at => updated_at}
      Merchant.new(hash)
    end
  end

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
