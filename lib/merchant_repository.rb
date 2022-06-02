require 'CSV'
require 'pry'
require_relative 'merchant'

class MerchantRepository
  attr_accessor :file_path, :all

  def initialize(file_path)
    @file_path = file_path
    @all =[]
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id =>row[:id], :name => row[:name]})

    end
  end

  def find_by_id(merchant_id)
    @all.find {|merchant| merchant.id == merchant_id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name == name}
  end

  def find_all_by_name(name)
    @all.find_all {|merchant| merchant.name == name}
  end

  def create(name)
    id = (@all.last.id.to_i + 1).to_s
    @all << Merchant.new({:id => id, :name => name})
  end

  def update(id, attributes)
    @all.each do |merchant|
      if merchant.id == id
        merchant.name = attributes
      end
    end
  end
#refactor delete
  def delete(id)
    array = []
      @all.each do |merchant|
        if merchant.id != id
          array << merchant
        end
      @all = array
    end
  end
end
