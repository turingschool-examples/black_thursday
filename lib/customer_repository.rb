require_relative './customer'
require_relative './repository'

class CustomerRepository < Repository

  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol ) do |datum|
      @data << Customer.new(datum)
    end
  end

  def find_all_by_first_name(name)
    @data.find_all do |datum|
      datum.first_name == name
    end
  end

  def find_all_by_last_name(name)
    @data.find_all do |datum|
      datum.last_name == name
    end
  end

  def create(attributes)
    highest_id = @data.max_by do |datum|
      datum.id
    end.id
    new_customer_id = highest_id += 1
    attributes[:id] = new_customer_id
    new_customer = Customer.new(attributes)

    @data << new_customer
    return new_customer
  end

  def update(id, attributes)
    item = find_by_id(id)
    return if item.nil?
    attributes.each do |key, value|
      item.first_name = value if key == :first_name
      item.last_name = value if key == :last_name
    end
    current_time = Time.now + 1
    item.updated_at = current_time.to_s
  end
end
