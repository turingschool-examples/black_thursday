require_relative "../lib/merchant"
require "csv"
require 'pry'

class MerchantRepository
attr_reader :all

  def initialize(data_path, sales_engine=nil)
    @sales_engine = sales_engine
    @all = []
    csv_loader(data_path)
    merchant_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def merchant_maker
    @all = @csv.map do |row|
      Merchant.new(row, self)
    end
  end

  def find_by_id(id_input)

    @all.find do |instance|
      instance.id == id_input.to_i
    end
  end

  def find_by_name(name_input)
    @all.find do |instance|
      instance.name.downcase == name_input.to_s.downcase
    end
  end

  def find_all_by_name(name_fragment)
    @all.find_all do |instance|
      instance.name.downcase.include?(name_fragment.to_s.downcase)
    end
  end

  def inspect
  end




end
