require 'CSV'
require_relative "merchant"
require_relative '../modules/findable'
require_relative '../modules/changeable'

class MerchantRepository
  include Findable
  include Changeable
  attr_accessor :merchants,
              :all,
              :name

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(row)
    end
    @all
  end


  def create(attributes)
    attributes[:id] = (@all.max {|merchant| merchant.id}).id + 1
      new_merchant = Merchant.new(attributes)
        @all << new_merchant
          new_merchant
  end

  def update(id, attributes)
    merchant = find_by_id(id)
    if merchant == nil
      exit
    else
      merchant.name = attributes[:name]
    end
  end


end
