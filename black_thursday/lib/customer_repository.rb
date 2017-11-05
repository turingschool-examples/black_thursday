class CustomerRepository
  attr_reader :customers,
              :parent

  def initialize(csv_filename, parent = nil)
    @customers  = load_csv(csv_filename).map { |row| Customer.new(row, self) }
    @parent    = parent
  end

  def load_csv(filename)
    CSV.open filename, headers: true, header_converters: :symbol
  end

  def all
    @customers
  end

  def find_by_id(id)
    return nil if id.nil?
    @customers.find { |customer| customer.id == id }
  end

  def find_all_by_first_name(name)
    return [] if name.nil?
    @customers.find_all do |customer|
      customer.first_name.downcase == name.downcase
    end
  end

  def find_all_by_last_name(name)
    return [] if name.nil?
    @customers.find_all do |customer|
      customer.last_name.downcase == name.to_s.downcase
    end
  end
end