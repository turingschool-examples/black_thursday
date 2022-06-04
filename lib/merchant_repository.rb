require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []
    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
    end
  end

  def find_by_id(id)
    @all.find { |merchant| merchant.id == id }
  end

  def find_by_name(name)
    @all.find { |merchant| merchant.name.downcase == name.downcase }
  end

  def find_all_by_name(name)
    @all.find_all { |merchant| merchant.name.downcase.include?(name.downcase) }
  end

  def create(attributes)
    attributes[:id] = @all.max_by {|merchant| merchant.id }.id + 1
    @all << Merchant.new(attributes)
    @all.last
  end

  def update(id, attributes)
    if find_by_id(id)
      find_by_id(id).update(attributes)
    end
  end

  def delete(id)
    @all.delete_if { |merchant| merchant.id == id }
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
