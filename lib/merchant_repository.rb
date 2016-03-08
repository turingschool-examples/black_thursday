require_relative '../lib/merchant'
require 'csv'
require 'pry'


class MerchantRepository
  attr_accessor :repository

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @repository = []
  end

  def all
    @repository
  end

  def find_by_id(number)
    repository.find do |merchant|
      merchant.id == number
    end
  end

  def find_by_name(name)
    repository.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name_fragment)
    found = repository.find_all do |merchant|
      merchant.name.downcase.include?(name_fragment.downcase)
    end
  end

  def items_per_merchant_hash #need test?
    # all.each_with_object([]) {|merchant, array| array << [merchant.id, merchant.items] }.to_h
    all.map { |merchant| [merchant.id, merchant.items] }.to_h
  end

  def item_count_per_merchant_hash # need test?
    items_per_merchant_hash.map { |merchant, items| [merchant, items.count] }.to_h
  end

  def invoices_per_merchant_hash # need test?
    # all.each_with_object([]) { |merchant, array| array << [merchant.id, merchant.invoices]}.to_h
    all.map { |merchant| [merchant.id, merchant.invoices] }.to_h
  end

  def invoice_count_per_merchant_hash # need test?
    invoices_per_merchant_hash.map { |merchant, invoices| [merchant, invoices.count]}.to_h
  end

  def sort_all_by_earned_revenue(number_of_earners)
    all.max_by(number_of_earners) do |merchant|
      merchant.all_revenue
    end
  end


  def inspect
  end
end
