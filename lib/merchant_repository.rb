require_relative './data_repository'
require_relative './merchant'

class MerchantRepository < DataRepository
  def initialize(data)
    super(data, Merchant)
  end

  def merchants
    return @data_set.values
  end

  # returns either [] or one or more matches which contain the supplied name
  # fragment, case insensitive
  def find_all_by_name(name)
      @data_set.values.find_all do |element|
      element.name.downcase.include?(name.downcase)
    end
  end

end
