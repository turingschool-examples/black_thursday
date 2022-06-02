require 'CSV'
require_relative "merchant"

class MerchantRepository

  attr_reader :merchants,
              :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
      # require "pry"; binding.pry
    end
    @all
  end

  def self.from_csv(data)
    MerchantRepository.new(data[:merchants])
  end

  def find_by_id(id)
    @all.find {|merchant| merchant.id == id}
  end

  def find_by_name(name)
    @all.find {|merchant| merchant.name.downcase == name.downcase}
  end

  def find_all_by_name(name)
    @all.find_all {|names| names.name.include?(name)}
  end

  def create(attributes)
    attributes[:id] = (@all.max {|merchant| merchant.id}).id + 1
      new_merchant = Merchant.new(attributes)
        @all << new_merchant
          new_merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    merchant.name[0..1000000] = attributes[:name]
  end

  def delete(id)
    merchant = find_by_id(id)
    @all.delete(merchant)
  end
end
