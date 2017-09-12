require_relative 'merchant'
require 'csv'

class MerchantRepository 
  attr_accessor :all

  def initialize(file_path)
    @all = csv_parse(file_path).map {|row| Merchant.new(row)}
  end

  def csv_parse(file_path)
    CSV.open file_path, headers: true, header_converters: :symbol
  end

  def find_by_id(id_number)
    all.find {|merchant| merchant.id.to_i == id_number.to_i}
  end

  def find_by_name(name)
    all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(fragment)
    all.reduce([]) do |array, merchant|
      name     = merchant.name.downcase 
      fragment = fragment.downcase
      array << merchant if name.include?(fragment)
      array
    end
  end
end