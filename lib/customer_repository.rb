require_relative './repo_methods'
require_relative './customer'
require 'CSV'
require 'time'
require 'pry'

class CustomerRepository
  include RepoMethods

  attr_reader :objects_array


  def initialize(file_path)
    @objects_array = customer_csv_converter(file_path)
  end

  def customer_csv_converter(file_path)
    csv_objs = CSV.read(file_path, {headers: true, header_converters: :symbol})
    csv_objs.map do |obj|
      obj[:id] = obj[:id].to_i
      obj[:updated_at] = Time.parse(obj[:updated_at])
      obj[:created_at] = Time.parse(obj[:created_at])
      Customer.new(obj.to_h)
    end
  end

  def find_all_by_first_name(name)
    @objects_array.find_all do |object|
      object.first_name.downcase =~ /#{name.downcase}/
    end
  end

  def find_all_by_last_name(name)
    @objects_array.find_all do |object|
      object.last_name.downcase =~ /#{name.downcase}/
    end
  end

  def create(attributes)
    max_id = generate_id
    time = attributes[:created_at].getutc
    attributes = {:id => max_id,
          :first_name => attributes[:first_name],
          :last_name => attributes[:last_name],
          :created_at => time,
          :updated_at => time}
    @objects_array << Customer.new(attributes)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    attributes.each do |attribute, value|
      if attribute == :first_name
        customer.first_name = value
        customer.updated_at = Time.new.getutc
      elsif attribute == :last_name
        customer.last_name = value
        customer.updated_at = Time.new.getutc
      else
        'You can not modify this attribute'
      end
    end
  end
end
