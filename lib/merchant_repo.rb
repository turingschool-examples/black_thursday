require 'csv'
require 'time'
require_relative 'merchant'
require_relative '../lib/load_file'


class MerchantRepo
  attr_reader :merchants,
              :parent

  def initialize(data, parent)
    @merchants = data.map {|row| Merchant.new(row, self)}
    @parent = parent
  end

  def all
    merchants
  end

  def find_by_id(id)
    all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def find_max_id
    max = all.max_by { |merchant| merchant.id }
    max.id.to_i + 1
  end

  def create(attrs)
    attrs[:id] = find_max_id.to_s
    new_merchant = Merchant.new(attrs, self)
    new_merchant.created_at = Time.now
    new_merchant.updated_at = Time.now
    all << new_merchant
  end

  def update(id, attrs)
    merchant = find_by_id(id)
    if merchant == nil
      return nil
      # this elsif block may be unnecessary may be able to use original update
    elsif attrs.key?(:id) == true
      return nil
    else
      merchant.name = attrs[:name]
      merchant.updated_at = Time.now.strftime("%Y-%m-%d")
    end
  end

  def delete(id)
    merchant = find_by_id(id)
    all.delete(merchant)
  end
end
