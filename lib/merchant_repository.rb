require "pry"
require "csv"
require_relative "./merchant"

class MerchantRepository
  attr_reader :merchant_repo

  def initialize(merchants_path)
    @merchant_repo = []

    CSV.foreach(merchants_path, headers: true, header_converters: :symbol){|row| merchant_repo << convert_to_merchant(row)}
  end

  def convert_to_merchant(row)
    row = Merchant.new({id: row[:id], name: row[:name], created_at: row[:created_at], updated_at: row[:updated_at]})
  end

  def all
    @merchant_repo
  end

  def find_by_id(id)
    @merchant_repo.find{|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @merchant_repo.find{|merchant| merchant.name.downcase == name.downcase.strip}
  end

  def find_all_by_name(name)
    @merchant_repo.find_all{|merchant| merchant.name.downcase.include?(name.downcase.strip)}
  end

  def create(attributes)
    @merchant_repo << new_merchant = Merchant.new(attributes)
  end

  def update(id, attributes)
    record = find_by_id(id)
    record.name = attributes
  end

  def delete(id)
    remove = find_by_id(id)
    @merchant_repo.delete(remove)
  end
end
