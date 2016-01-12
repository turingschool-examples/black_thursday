require 'csv'
require 'merchant'

class MerchantRepository
attr_reader :data, :all_merchants
attr_accessor :file

  def initialize
    @all_merchants = []
  end

  def load_data(file)
    @data = CSV.open (file), headers: true, header_converters:
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
