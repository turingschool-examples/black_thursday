require_relative 'customer'

class CustomerRepository
  attr_reader :customers

  def initialize(file_path, engine)
    @engine = engine
    @customers = create_repository(file_path)
  end

  def create_repository(file_path)
    file = CSV.readlines(file_path, headers: true, header_converters: :symbol)
    file.map do |row|
      Customer.new(row)
    end
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def all
    @customers
  end

  def find_by_id(id)
    @customers.find do |customer|
      customer.id.to_i == id
    end
  end

  def find_all_by_first_name(name)
      @customers.find_all do |customer|
        customer.first_name.casecmp(name) == 0
      end
    end

  def find_all_by_last_name(name)
      @customers.find_all do |customer|
        customer.last_name.casecmp(name) == 0
      end
    end

    def max_customer_id
      @customers.max_by do |customer|
        customer.id
      end.id
    end

  def create(attributes)
    @customers.push(Customer.new({
                  :id         => max_customer_id + 1,
                  :first_name => 'First',
                  :last_name  => 'Last',
                  :created_at => Time.now,
                  :updated_at => Time.now,
                  }))
  end

  def update(id, attributes)
    customer = find_by_id(id)
    return nil if customer.nil?
    attributes.each do |key, value|
      if value == attributes[:first_name]
        customer.first_name = attributes[key]
      elsif value == attributes[:last_name]
        customer.last_name = attributes[key]
      end
    end
    customer.updated_at = Time.now
  end

  def delete(id)
    @customers.delete(find_by_id(id))
  end
end
