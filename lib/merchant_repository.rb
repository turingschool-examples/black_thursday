require_relative './sales_engine'
require_relative './merchant'

class MerchantRepository
  attr_reader :data,
              :merchant_info

  def initialize(data, engine)
    @data = data
    @engine = engine
    @merchant_info = populate_repo
  end

  def populate_repo
    merchant = Hash.new{|h,k| h[k] = []}
    merchant_data = CSV.open @data, headers: true, header_converters: :symbol
    merchants = merchant_data.map do |row|
        merchant[row[:id]] = Merchant.new(row, self)
    end
    merchant
  end

  def all
    @merchant_info.values
  end

  def find_by_id(id)
    @merchant_info.find do |merchant|
      merchant[0] == id.to_s
    end
  end

  def find_by_name(name)
    @merchant_info.find do |merchant|
      merchant[1].name.upcase == name.upcase
    end
  end

  def find_all_by_name(search_string)
    @merchant_info.find_all do |key, value|
      value.name.upcase.include?(search_string.upcase)
    end
  end

  def find_all_by_name(search_string)
    @merchant_info.find_all do |key, value|
      value.name.upcase.include?(search_string.upcase)
    end
  end

  def max_id
    @merchant_info.max_by do |key, record|
      record.id
    end
  end

  def new_id
    max_id[0].to_i + 1
  end

  def create(new_data)
    @merchant_info[:new_id.to_s] = Merchant.new({:id => new_data[:id].to_s, :name => new_data[:name], :created_at => new_data[:created_at], :updated_at => new_data[:updated_at]}, @repository)
  end

  def update(id, new_name)
    @merchant_info[id] = Merchant.new({:id => id, :name => new_name, :created_at => created_at, :updated_at => updated_at}, @repository)
  end

  def delete(id)
    @merchant_info.delete_if do |key, value|
      key == id
    end
  end

end
