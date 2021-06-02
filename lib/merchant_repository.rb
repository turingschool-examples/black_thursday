require 'csv'
require_relative '../lib/merchant'

class MerchantRepository
  attr_reader :all

  def initialize(path)
    @all = [] #path create_items(path) - will need to update but tests need updated for mocks and specs
    create_merchants(path)
  end

  def create_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      merchant = Merchant.new({
                                :id   => row[:id].to_i,
                                :name => row[:name]
                                })
      @all << merchant
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    # require 'pry'; binding.pry
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.casecmp?(name)
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.casecmp?(name)
    end
  end

  def create(attribute)
    new_id = @all.max_by do |merchant|
      merchant.id
    end
    merchant = Merchant.new({:id => new_id.id + 1, :name => attribute})
    @all << merchant
    merchant
  end

  def update(id, new_name)
    name_edit = find_by_id(id)
    name_edit.name = new_name
  end

  def delete(id)
    delete_merchant = find_by_id(id)
    @all.delete(delete_merchant)
  end
end
