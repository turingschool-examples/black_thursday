require 'csv'
require 'time'
require_relative 'merchant'


class MerchantRepo
  attr_reader :all

  def initialize(csv_file)
    @all = []
    open_file(csv_file)
  end

  def open_file(file)
    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      all << Merchant.new(row)
    end
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
    new_merchant = Merchant.new(attrs)
    new_merchant.created_at = Time.now
    new_merchant.updated_at = Time.now
    all << new_merchant
  end

  def update(id, attrs)
    merchant = find_by_id(id)
    merchant.name = attrs[:name]
    merchant.updated_at = Time.now.strftime("%Y-%m-%d")
  end

  def delete(id)
    merchant = find_by_id(id)
    all.delete(merchant)
  end
end
