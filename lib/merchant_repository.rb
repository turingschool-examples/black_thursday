require_relative './repository_module'
require 'pry'

class MerchantRepository
  include RepoMethods

  def initialize(filepath = nil)
    @filepath = filepath
    @all = []
    split(filepath) if filepath != nil
  end

  def create(attributes)
    isnt_included = @all.any? do |merchant|
      attributes[:id] != merchant.id
    end
    has_id = attributes[:id] != nil
    if has_id && isnt_included
      @all << Merchant.new(attributes)
    elsif @all == []
      new_id = 1
      attributes[:id] = new_id
      @all << Merchant.new(attributes)
    else
      highest_id = @all.max_by do |merchant|
        merchant.id
      end.id
      new_id = highest_id + 1
      attributes[:id] = new_id
      @all << Merchant.new(attributes)
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant_name = merchant.name.downcase
      merchant_name.include?(name.downcase)
    end
  end

end
