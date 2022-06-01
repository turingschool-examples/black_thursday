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
      merchant.name == name
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
  end

  def create(data)
    @all << Merchant.new({id: data[:id], name: data[:name]})
    # if id needs to be +1 last id, id: (@all.last.id.to_i + 1).to_s
  end

  def update(id, name)
    if find_by_id(id) != nil
      @all.delete_if do |merchant|
        merchant.id == id
      end
      @all << Merchant.new({id: id, name: name})
      # does this need to have both merchant attributes as the second argument?
    end
  end

  def delete(id)
    @all.delete_if do |merchant|
      merchant.id == id
    end
  end
end
