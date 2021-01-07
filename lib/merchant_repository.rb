require "pry"
require "csv"
require_relative "./merchant"

class MerchantRepository
  attr_reader :all

  def initialize(merchants_path)
    @all = []

    CSV.foreach(merchants_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_merchant(row)
    end
  end

  def convert_to_merchant(row)
    row = Merchant.new({id: row[:id], name: row[:name], created_at: row[:created_at], updated_at: row[:updated_at]})
  end

  def find_by_id(id)
    @all.find{|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find{|merchant| merchant.name.downcase == name.downcase.strip}
  end

  def find_all_by_name(name)
    @all.find_all{|merchant| merchant.name.downcase.include?(name.downcase.strip)}
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @all << Merchant.new(attributes)
  end

  def update(id, attributes)
    record = find_by_id(id)
    record.name = attributes
  end

  def delete(id)
    remove = find_by_id(id)
    @all.delete(remove)
  end

  def new_highest_id
    all.max_by do |instance|
      instance.id
    end.id + 1
  end
end
