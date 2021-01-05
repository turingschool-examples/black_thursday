require 'CSV'
require './lib/cleaner.rb'
require './lib/merchant.rb'

class MerchantRepository

  # def all
    # parse the data seperate id and name - Generate merchant entries from cleaner class.
    #  iterate through that
    #for each line attach data to new merchant object

  def initialize(file = '/Users/alexamsmyth/turing/1mod/projects/black_thursday/data/merchants.csv')
    @file = file
    @merchants = []
    @data = CSV.open(@file, headers: true, header_converters: :symbol)
  end

  def build_merchants
    @data.map do |merchant|
      cleaner = Cleaner.new
      merch = Merchant.new({ id: cleaner.clean_id(merchant[:id]),
                            name: cleaner.clean_name(merchant[:name]),
                            created_at: cleaner.clean_date(merchant[:created_at]),
                            updated_at: cleaner.clean_date(merchant[:updated_at])})
      @merchants << merch
      end
    @merchants
  end
end
