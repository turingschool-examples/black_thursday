require 'csv'
require './lib/merchant'

class MerchantRepository
  attr_reader :merchants

  def initialize(csv_file)
    @merchants = {}
    populate_merchant_repo(csv_file)
  end

  def populate_merchant_repo(csv_file)
    merchant_list = CSV.open csv_file, headers: true, header_converters: :symbol
    merchant_list.each do |row|
      individual = Merchant.new({:id => row[:id], :name => row[:name]})
      @merchants[individual.id] = individual
    end
  end

  def all
    @merchants.each {|key, value| puts value}
  end

  def find_by_name(name)
    name = name.downcase
    @merchants.each_value do |value|
      if value.name == name
        return value
      else
        next
      end
    end
    nil
  end

  def find_by_id(id)
    id = id.to_i
    @merchants.each_key do |key|
      if key == id
        return @merchants[key]
      else
        next
      end
    end
    nil
  end

  def find_all_by_name(snippet)
    return_matches = []
    snippet = snippet.downcase
    @merchants.each_value do |value|
      if value.name.include?(snippet)
        return_matches << value.name
      end
    end
    return_matches
  end

end
