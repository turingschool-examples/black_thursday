require_relative 'customer'

class CustomerRepository
  attr_reader :customers,
              :parent

  def initialize(csv_file = './data/customers.csv', parent = nil)
    @customers = load_csv(csv_file).map { |row| Customer.new(row, self) }
    @parent = parent
  end

  def from_csv(csv_file)
    CustomerRepository.new(csv_file)
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @customers
  end

  def find_by_id(id)
    return nil if id.class != Integer
    customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    return [] if name.class != String
    customers.find_all do |customer|
      customer.first_name.downcase.include?(name.downcase)
    end
  end

  def find_all_by_last_name(name)
    return [] if name.class != String
    customers.find_all do |customer|
      customer.last_name.downcase.include?(name.downcase)
    end
  end

  def inspect
    "#{self.class} has #{all.count} rows"
  end
end
