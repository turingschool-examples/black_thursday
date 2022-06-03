require 'csv'
require_relative 'merchant'

class MerchantRepository

  attr_reader :all

  def initialize(filepath)
    @filepath = filepath
    @all = []

    CSV.foreach(@filepath, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({id: row[:id], name: row[:name]})
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(attributes)
    new_id = @all.max_by {|merchant| merchant.id }.id + 1
    attributes[:id] = new_id
    @all << Merchant.new(attributes)
    return @all.last
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      find_by_id(id).update(attributes)
    end
  end

  # def update(id, name)
  #   if find_by_id(id) != nil
  #     @all.delete_if do |merchant|
  #       merchant.id == id
  #     end
  #     @all << Merchant.new({id: id, name: name})
  #   end
  # end

  def delete(id)
    @all.delete_if do |merchant|
      merchant.id == id
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end
