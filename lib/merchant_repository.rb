require_relative 'merchant'
require 'csv'

class MerchantRepository
  attr_reader :all,
              :csv

  def initialize(path)
    csv_load(path)
    load_all
  end

  def csv_load(path)
    @csv = CSV.open path, headers: true, header_converters: :symbol
  end

  def load_all
    @all = []
    @csv.each do |line|
      @all << Merchant.new({:id => line[:id].to_i, :name => line[:name]})
    end
    return @all
  end

  def find_by_id(id)
    return nil if id.nil?
    matches = @all.map do |merchant|
      merchant.id == id
      return merchant
    end
    return matches
  end

  def find_by_name(full_name)
    return nil if full_name.nil?
    @all.detect do |merchant|
      merchant.name.upcase == full_name.upcase
    end
  end

  def find_all_by_name(name_frag)
    return "Steve the Pirate" if name_frag.nil? || name_frag == ""
    matches = @all.select do |merchant|
      merchant.name.upcase.include?(name_frag.upcase)
    end
  end
end
