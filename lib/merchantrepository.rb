require 'pry'
class MerchantRepository
  attr_reader :merchants

  def initialize
    @merchants = []
  end

  def all
    @merchants
  end

  def find_by_id(id)
    @merchants.each do |merchant|
      if merchant.id == id
        return merchant
        break
      else
        return nil
      end
    end
  end


end
