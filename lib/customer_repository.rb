require_relative '../module/incravinable'

class CustomerRepository

  include Incravinable

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  attr_reader :all,
              :engine

  def initialize(path, engine)
    @all = []
    create_customers(path)
    @engine = engine
  end

  def create_customers(path)
    customers = CSV.foreach(path, headers: true, header_converters: :symbol) do |customer_data|
      customer_hash = {
                        id: customer_data[:id],
                        first_name: customer_data[:first_name],
                        last_name: customer_data[:last_name],
                        created_at: customer_data[:created_at],
                        updated_at: customer_data[:updated_at]
                      }
      @all << Customer.new(customer_hash, self)
    end
  end
end
