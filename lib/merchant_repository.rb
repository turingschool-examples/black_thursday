require 'csv'
require_relative 'merchant'
class MerchantRepository

  attr_reader :all

  def initialize(file_path)
    @all = []
    populate_merchants(file_path)
  end

  def populate_merchants(file_path)
    CSV.foreach(file_path, row_sep: :auto, headers: true) do |line|
      self.all << Merchant.new(line)
    end
  end

  def find_by_id(id)
    @all.find do |merchant|
      merchant.id == id
    end
  end

  def find_by_name(name)
    @all.find do |merchant|
      merchant.name.downcase == name.downcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |merchant|
      merchant.name.downcase.include? name.downcase
    end
  end


end
