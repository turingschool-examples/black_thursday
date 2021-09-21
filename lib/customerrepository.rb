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
    @all.find_all do |customer|
      customer.id == id
    end.pop
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
    new = Customer.new(attributes)
    @all.push(new)
  end

  def update(id, attributes)

      updated_customer = self.find_by_id(id)
      updated_customer.first_name = attributes[:first_name]
      updated_customer.last_name = attributes[:last_name]
      updated_customer.updated_at = Time.now
    updated_customer
  end

  def delete(id)
    c_1 = (self.all).find_index(self.find_by_id(id))
    self.all.delete_at(c_1)
    self.all
  end

  def inspect
   "#<#{self.class} #{@customer.size} rows>"
 end
end
