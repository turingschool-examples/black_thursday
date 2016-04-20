require './lib/merchant'
require './lib/item_repository'
require 'pry'

class MerchantRepository
  attr_reader :merchant_repository

  def initialize(parent)
    @se = parent
    @merchant_repository = []
  end

  def merchants(merchant_contents)
    merchant_contents.each do |column|
      @merchant_repository << Merchant.new(column, self)
    end
    self
  end

  def all
    merchant_repository.empty? ?  nil : merchant_repo
  end

  def find_by_id(find_id)
    merchant_repository.find {|merchant| merchant.id == find_id }
  end

  def find_by_name(find_name)
    merchant_repository.find {|merchant| merchant.name.downcase == find_name.downcase }
  end

  def find_all_by_name(find_name)
    merchant_repository.find_all {|merchant| merchant.name.downcase.include?(find_name.downcase)}
  end

  def find_items_by_merchant_id(merchant_id)
    @se.find_items_by_merch_id(merchant_id)
  end





end
