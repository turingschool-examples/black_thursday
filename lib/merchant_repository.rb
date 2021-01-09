require 'pry'
require 'csv'
require 'time'
require_relative './merchant'

class MerchantRepository
  attr_reader :all,
              :engine

  def initialize(merchants_path, engine)
    @all = []
    @engine = engine

    CSV.foreach(merchants_path, headers: true, header_converters: :symbol) do |row|
      @all << convert_to_merchant(row)
    end
  end

  def convert_to_merchant(row)
    row = Merchant.new({id: row[:id],
                        name: row[:name],
                        created_at: row[:created_at],
                        updated_at: row[:updated_at]},
                        self)
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase.strip
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase.strip)
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    merchant = Merchant.new(attributes, self)
    @all << merchant
    merchant
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      update_merchant = all.find { |merchant| merchant.id == id }
      update_merchant.name = attributes
      update_merchant.updated_at = Time.now
    end
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
