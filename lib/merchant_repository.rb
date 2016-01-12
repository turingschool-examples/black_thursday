require 'csv'
require 'merchant'

class MerchantRepository
attr_reader :data, :all
attr_accessor :file
  def initialize
    @all = []
  end

  def load_data(file)
    @data = CSV.open "#{file}", headers: true, header_converters:
    :symbol
  end

  def data_into_hash(data)
    data.each do |row|
      merchant_id = row[0]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]

      hash = {:merchant_id => merchant_id,
              :name => name, :created_at => created_at, :updated_at => updated_at}
      merchant = Merchant.new(hash)

      @all << merchant
    end
  end

  def find_by_id

  end

  def find_by_name

  end
end
