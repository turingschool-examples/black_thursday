require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new({:id => row[:id], :name => row[:name]})
    end
  end

  def find_by_id(merchant_id_search)
    @all.find do |merchant|
      merchant.id == merchant_id_search
    end
  end

  def find_by_name(merchant_name_search)
    @all.find do |merchant|
      merchant.name.downcase == merchant_name_search.downcase
    end
  end

  def find_all_by_name(name_fragment_search)
    @all.find_all do |merchant|
      merchant.name.downcase.include?("#{name_fragment_search.downcase}")
    end
  end

  def create(new_merchant)
    new_id = 0
    @all.each do |merchant|
      if merchant.id.to_i > new_id
        new_id = merchant.id.to_i + 1
      end
    end
    @all << Merchant.new({:id => new_id.to_s, :name => new_merchant})
  end

  def update(merchant_id_search, new_name)
    @all.find do |merchant|
      merchant.id == merchant_id_search
      merchant.info[:name] = new_name
    end
  end

  # def delete(id)
  #   @all.delete()
  # end

end
