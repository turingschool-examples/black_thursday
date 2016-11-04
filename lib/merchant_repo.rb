require './lib/merchant'
require 'csv'
require 'pry'
require './lib/sales_engine'

class MerchantRepo
  attr_reader :name,
              :id,
              :created_at,
              :updated_at,
              :all


  def initialize(file, sales_engine)
    @parent = sales_engine
    @all = []
    file_reader(file)
  end

  def file_reader(file)
    contents = CSV.open(file, headers:true, header_converters: :symbol)
    contents.each do |merchant|
       @all << Merchant.new(merchant, self)
    end
  end

  def find_by_id(desired_id)
    m = @all.find do |merchant| 
       merchant.id == desired_id
    end
    m
  end

  def find_by_name(desired_name)
    desired_name.to_s.downcase
    @all.find {|merchant| merchant.name == desired_name}
  end

  def find_all_by_name(fragment)
    fragment = fragment.to_s.downcase
    @all.find_all do |merchant|
      merchant.name.downcase.include?(fragment)
    end
  end

  def find_all_by_merchant_id(id)
    @parent.find_all_by_merchant_id(id)
  end

end

