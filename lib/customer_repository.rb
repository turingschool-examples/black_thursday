require_relative 'customer'

class CustomerRepository
  attr_reader :repository
  def initialize(data, sales_engine = nil)
    @sales_engine = sales_engine
    @repository = {}
    load_csv_file(data)
  end

  def load_csv_file(data)
    CSV.foreach(data, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
      data = row.to_h
      repository[data[:id].to_i] = Customer.new(data, self)
    end
  end

  def all
    repository.values
  end

  def find_by_id(id)
    repository[id]
  end

  def find_all_by_first_name(fragment)
    all.find_all do |customer|
      customer.first_name.downcase.include?(fragment.downcase)
    end
  end

  def find_all_by_last_name(fragment)
    all.find_all do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end
  end

  def fetch_merchant_by_customer_id(id)
    @sales_engine.fetch_merchant_by_customer_id(id)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

end
