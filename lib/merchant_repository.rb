require './lib/merchant'

class MerchantRepository

  attr_reader :merchants

  def initialize(merchants_file_path, se)
    @merchants = []
    contents = CSV.open merchants_file_path,
                 headers: true,
                 header_converters: :symbol
    contents.each do |row|
      id = row[:id]
      name = row[:name]
      created_at = row[:created_at]
      updated_at = row[:updated_at]
      merchant = Merchant.new(id, name, created_at, updated_at)
      @merchants << merchant
    end
  end
end