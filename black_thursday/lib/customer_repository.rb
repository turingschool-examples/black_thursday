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
    return nil if id.class != Integer
    @customers.find { |customer| customer.id == id }
  end
end