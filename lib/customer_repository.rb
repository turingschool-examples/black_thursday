require_relative 'inspectable'

class CustomerRepository
  include Inspectable

  attr_reader :sales_engine, :file_path, :all

  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @all = generate
  end

  def generate
    info = CSV.open(@file_path.to_s, headers: true, header_converters: :symbol)
    info.map do |row|
      Customer.new(row, self)
    end
  end

  def find_by_id(id)
    @all.find do |customer|
      customer.id == id
    end
  end

  def find_all_by_first_name(first_name)
    @all.find_all do |customer|
      customer.first_name.downcase.include?(first_name.downcase)
    end
  end

  def find_all_by_last_name(last_name)
    @all.find_all do |customer|
      customer.last_name.downcase.include?(last_name.downcase)
    end
  end

  # Remember to copy this style
  def create(attributes)
    attributes[:id] = @all.last.id + 1
    @all << Customer.new(attributes, self)
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return nil if customer.nil?

    customer.update_customer(attributes)
  end
end