require './lib/merchant'
require './lib/item_repository'
require 'pry'

class MerchantRepository

  def initialize(parent)
    @se = parent
  end

  def merchants(merchant_contents)
    merchant_contents.map do |column|
      merchants = Merchant.new(column, self)
    end
  end

  def all
    @merchant_repo.empty? ?  nil : @merchant_repo
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
