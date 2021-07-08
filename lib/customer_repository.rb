require_relative 'customer'

class CustomerRepository
  attr_reader :all,
              :sales_engine

  def initialize(parent = nil)
    @all = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

  def populate(filename)
    CSV.foreach(filename, headers: true, header_converters: :symbol) do |row|
      @all << Customer.new(row, self)
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

  def find_invoices_by_customer_id(customer_id)
    @sales_engine.find_invoices_by_customer_id(customer_id)
  end

end
