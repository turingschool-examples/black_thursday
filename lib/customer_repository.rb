require_relative 'customer'
require 'csv'

class CustomerRepository

  attr_reader :sales_engine,
              :file_path,
              :id_repo

  def initialize(file_path, sales_engine)
    @file_path    = file_path
    @sales_engine = sales_engine
    @id_repo      = {}
    load_repo
  end

  def load_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      customer_identification = row[:id]
      customer = Customer.new(row, self)
      @id_repo[customer_identification.to_i] = customer
    end
  end

  def all
    id_repo.map do |id, customer_identification|
      customer_identification
    end
  end

  def find_by_id(id)
    id_repo[id]
  end

  def find_all_by_first_name(first_name_frag)
    id_repo.values.select do |customer_instance|
      customer_instance.first_name.downcase.include?(first_name_frag.downcase)
    end
  end

  def find_all_by_last_name(last_name_frag)
    id_repo.values.select do |customer_instance|
      customer_instance.last_name.downcase.include?(last_name_frag.downcase)
    end
  end

  def customer_repo_to_se_merchants(customer_id)
    @sales_engine.merchants_by_customer_id(customer_id)
  end

  def customer_merchants_by_customer_expenditure(customer_id)
    customer_merchants = customer_repo_to_se_merchants(customer_id)
    customer_merchants.sort_by do |merchant|
      merchant.revenue_by_customer_id(customer_id)
    end
  end

  def customers_by_expenditure
    all.sort_by do |customer|
      invoices = @sales_engine.invoices_by_customer_id(customer.id)
      invoices.reduce(0) do |total, invoice|
        total += invoice.total
      end
    end
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

end
