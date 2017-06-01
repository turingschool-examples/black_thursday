require 'csv'
require './lib/merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(csv_file)
    @merchants = []
    populate_merchant_repo(csv_file)
  end

  def populate_merchant_repo(csv_file)
    merchant_list = CSV.open csv_file, headers: true, header_converters: :symbol
    merchant_list.each do |row|
      individual = Merchant.new({:id => row[:id], :name => row[:name]})
      @merchants << individual
    end
    merchant_list.close
  end

  def all
    @merchants.each {|merchant| puts merchant}
  end

  def find_by_name(name)
    return_value = @merchants.select do |merchant|
      merchant.name == name.downcase
    end
    puts return_value
    return return_value if return_value.empty? == false
    return nil if return_value.empty?
  end

  def find_by_id(id)
    return_value = @merchants.select do |merchant|
      merchant.id == id.to_i
    end
    puts return_value
    return return_value if return_value.empty? == false
    return nil if return_value.empty?
  end

  def find_all_by_name(snippet)
    return_matches = @merchants.select do |merchant|
      merchant.name.include?(snippet.downcase)
    end
    puts return_matches
    return_matches
  end


end
