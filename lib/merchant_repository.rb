require_relative './merchant'
require_relative './repo_methods'
require 'time'
require 'CSV'

class MerchantRepository
  include RepoMethods
  attr_reader :objects_array
  def initialize(file_path)
    @objects_array = merchant_csv_converter(file_path)
  end

  def merchant_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      Merchant.new(obj.to_h)
    end
  end

  def find_by_name(name)
    findings = @objects_array.find_all do |merchant|
      merchant.name.downcase == name.downcase
    end
    findings[0]
  end

  def find_all_by_name(name)
    @objects_array.find_all do |merchant|
      merchant.name.downcase =~ /#{name.downcase}/
    end
  end

  def create(name)
    last_merchant = @objects_array.last
    if last_merchant == nil
      max_id = 1
    else
      max_id = last_merchant.id + 1
    end
    attributes = {:id => max_id, :name => name[:name]}
    @objects_array << Merchant.new(attributes)
  end

  def update(id, attributes)
    name = attributes[:name]
    merchant = find_by_id(id)
    if merchant != nil and name != nil
      merchant.updated_at = Time.new.getutc
      merchant.name = name
    end
  end
end
