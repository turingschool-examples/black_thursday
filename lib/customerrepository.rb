require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :all

  def initialize(file_path, engine)
    @engine = engine
    @all = create_repository(file_path)
  end

  def create_repository(file_path)
    all = []

    csv = CSV.read(file_path, headers: true, header_converters: :symbol)
     csv.map do |row|
       all << Customer.new(row)
    end
    all
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    name_1 = first_name.downcase

      @all.find_all do |customer|
        first_name1 = customer.first_name.downcase
        first_name1.include?(name_1)
      end
  end

  def find_all_by_last_name(last_name)
    name_1 = last_name.downcase

      @all.find_all do |customer|
        last_name1 = customer.last_name.downcase
        last_name1.include?(name_1)
      end
  end

  def create(attributes)
    id_max = @all.max_by {|customer| customer.id}
    attributes[:id] = id_max.id + 1
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    new = Customer.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)

      updated_customer = self.find_by_id(id)
    if updated_customer != nil
      if attributes[:first_name] == nil && attributes[:last_name] == nil

      elsif attributes[:first_name] != nil && attributes[:last_name] == nil
        updated_customer.first_name = attributes[:first_name]

      elsif attributes[:first_name] == nil && attributes[:last_name] != nil
        updated_customer.last_name = attributes[:last_name]
      end
      updated_customer.updated_at = Time.now
    end

  end

  def delete(id)
    @all.delete_if do |row|
      row.id == id
    end
  end

  def inspect
   "#<#{self.class} #{@customer.size} rows>"
 end
end
