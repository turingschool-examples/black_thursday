require_relative './enumerable'

class MerchantRepository
  include Enumerable
  attr_reader :file_path, :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(:id =>row[:id],:name => row[:name])
    end
  end

  def find_all_by_name(name)
    @all.find_all do |row|
      row.name.upcase.include?(name.upcase)
    end
  end

  def add_new(new_id, attributes)
    @all <<  Merchant.new({:id => new_id,:name => attributes})
  end

  def change(id, key, value)
    if key == :name
      find_by_id(id).name = value
    else
      return nil
    end
  end
end
