require './lib/merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = {}
  end

  def populate(merchants)
    merchants.each do |merchant|
      @merchants[merchant[:id]] = Merchant.new(merchant)
    end

    def all
      merchants.values
    end

    def find_by_id(merchant_id)
      merchants[merchant_id]
    end

    def find_by_name(merchant_name)
      merchants.values.find do |merchant|
        merchant.name.downcase == merchant_name.downcase
      end
    end

    def find_all_by_name(name_fragment)
      merchants.values.find_all do |merchant|
        merchant.name.downcase.include?(name_fragment.downcase)
      end
    end
  end

  # find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive


#LOOK UP hash method .merge

  # def <<
  #   @merchants <<
  # end

  # def all
  #
  # end

#   all - returns an array of all known Merchant instances

# find_by_id - returns either nil or an instance of Merchant with a matching ID

# find_by_name - returns either nil or an instance of Merchant having done a case insensitive search

# find_all_by_name - returns either [] or one or more matches which contain the supplied name fragment, case insensitive


  # def find_merchant_id(raw_data)
  #   merchant_line = raw_data.lines[0]
  #     id = merchant_line
  # end
  #
  # def find_merchant_name
  # end
  # #
  # def find_when_merchant_was_created
  # end
  #
  # def find_when_merchant_was_updated
  # end
end
