require 'CSV'
class MerchantRepository

  attr_reader :merchants

  def initialize(filepath)
    @merchants = []
    load_csv(filepath)
    #can we pass this directly to load_csv?
  end

  def load_csv(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol, converters: :numeric) do |row|
      @merchants << Merchant.new(row.to_h)
    end
  end

  def all
    @merchants
  end

  def find_by_id(merchant_id)
    found_merchant = ''
    @merchants.each do |merchant|
      if merchant.id == merchant_id
        found_merchant = merchant
        break
      else
        found_merchant = nil
      end
    end
    found_merchant
  end

  def find_by_name(merchant_name)
    found_merchant = ''
    @merchants.each do |merchant|
      if merchant.name.upcase == merchant_name.upcase
        found_merchant = merchant
        break
      else
        found_merchant = nil
      end
    end
    found_merchant
  end

  def find_all_by_name(name_fragment)
    found_merchants = []
    @merchants.each do |merchant|
      if merchant.name.upcase.include?(name_fragment.upcase)
        found_merchants << merchant
      end
    end
    found_merchants
  end
end




  # def get_all_merchants_from_csv
  #   #enumerable to iterate through all CSV lines
  #   create_merchant_object_array
  # end
  #
  # def create_merchant_object_array(csv, merchant_array = [])
  #     # merchant_array <<
  #
  # end
  #
  # def all
  #   get_all_merchants_from_csv
  #
  # end
  #
  # def find_by_id
  #   get_merchants_by_id
  # end
  #
  #
  # def get_merchants_by_id
  #   #do the things
  #   create_merchant_object_array
  # end
  #
  # def get_merchants_by_name
  #   #do the things
  #   create_merchant_object_array
  #
  # end
