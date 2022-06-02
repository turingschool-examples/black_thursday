require 'CSV'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(
        :id => row[:id].to_i,
        :name => row[:name]
        )
      end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |merchant|
      merchant.name.upcase.include?(name_fragment.upcase)
    end
  end

  def create(name)
    x = (@all.last.id + 1)
    @all << Merchant.new({:id => x, :name => name})
  end

  def update(id, attributes)
    x = find_by_id(id)
    x.name[0..1000000] = attributes[:name]
  end

  def delete(id)
    x = find_by_id(id)
    @all.delete(x) 
  end

end
