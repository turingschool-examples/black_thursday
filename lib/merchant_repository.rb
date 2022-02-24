require_relative '../lib/merchant'
require 'CSV'
require 'date'
require 'pry'

class MerchantRepository

  attr_reader :filename, :merchants

  def initialize(filename)
    @filename = filename
    @merchants = self.all
  end

  def rows
    rows = CSV.read(@filename, headers: true, header_converters: :symbol)
  end

  def current_highest_id
    sorted = @merchants.sort_by {|merchant| merchant.id}
    highest_id = sorted[-1].id
    highest_id.to_i
  end

  def all
    result = rows.map {|row| Merchant.new(row)}
  end

  def find_by_id(id)
    result = @merchants.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    result = @merchants.find {|merchant| merchant.name == name}
  end

  def find_all_by_name(fragment)
    result = @merchants.find_all {|merchant| merchant.name.include?(fragment.downcase)}
  end

  def create(name)
    id = current_highest_id + 1
    id = id.to_s
    @merchants << new_merchant = Merchant.new(id: id, name: name)
    new_merchant
  end

  def update(id, new_name)
    @merchants.each do |merchant|
      merchant.name = new_name if merchant.id == id
    end
  end

  def delete(id)
    deleted_merchant = find_by_id(id)
    @merchants.delete(deleted_merchant)
  end

end
