require 'csv'
require 'pry'
require './lib/merchant'

class MerchantRepository

  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row[:id],row[:name])
    end
  end

  def find_by_id(id_number)
    @all.find {|merchant| merchant.id == id_number.to_s}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase == name.downcase.strip}
  end

  def find_all_by_name(input)
    @all.select {|merchant| merchant.name.downcase.include?(input.downcase.strip)}
  end

  def max_id
    (@all.max_by {|merchant| merchant.id.to_i}).id.to_i
  end

end
