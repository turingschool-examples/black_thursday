require './lib/merchant'

class MerchantRepository

  def initialize(merchant_array)
    @merchant_repo = merchant_array
  end

  def all
    @merchant_repo.empty? ?  nil : @merchant_repo.to_a
  end

  def find_by_id(find_id)
    @merchant_repo.find {|item| item.id == find_id }
  end

  def find_by_name(find_name)
    @merchant_repo.find {|item| item.name.downcase == find_name.downcase }
  end

  def find_all_by_name(find_name)
    @merchant_repo.find_all {|item| item.name.downcase.include?(find_name.downcase)}
  end
end
