require './lib/merchant'
require './lib/data_parser'

class MerchantRepo
  include DataParser
  def all
    @all_merchants
  end

  def all_merchants(parsed)
    @all_merchants = parsed.map { |row| Merchant.new(row) }
    binding.pry
  end

  # def find_all
  #
  # end
  #
  # def find_by_id
  #
  # end
  #
  # def find_by_name
  #
  # end
  #
  # def find_all_by_name
  #
  # end
end
