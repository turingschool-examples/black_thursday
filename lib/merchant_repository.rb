require_relative './repository_module'
require 'pry'

class MerchantRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
  end

  def <<(merchant)
    @all << merchant
  end

  def create(attributes)
    if @all == []
      new_id = 1
    else
      highest_id = @all.max_by do |merchant|
        merchant.id
      end.id
      new_id = highest_id + 1
    end
    attributes[:id] = new_id
    @all << Merchant.new(attributes)
  end

  def find_all_by_name(name)
    @merchants.find_all do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name.include?(name.downcase)
    end
  end

end
