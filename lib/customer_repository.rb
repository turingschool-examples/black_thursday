require_relative './sales_engine'

class CustomerRepository
  attr_reader :all
  def initialize(customer_path)
    @all = (
      customer_objects = []
      CSV.foreach(customer_path, headers: true, header_converters: :symbol) do |row|
        customer_objects << Customer.new(row)
      end
      customer_objects)
  end

  def find_by_id(id)
    if (@all.any? do |customer|
      customer.id == id
    end) == true
      @all.find do |customer|
        customer.id == id
      end
    else
      nil
    end
  end

  def find_all_by_first_name(first_name)
    if (@all.any? do |customer|
        customer.first_name.upcase == first_name.upcase
      end) == true
        @all.find do |customer|
          customer.first_name.upcase == first_name.upcase
        end
    else
      nil
    end
  end

  def find_all_by_last_name(last_name)
    if (@all.any? do |customer|
         customer.last_name.upcase == last_name.upcase
       end) == true
         @all.find do |customer|
           customer.last_name.upcase == last_name.upcase
         end
    else
      nil
    end
  end

  def new_highest_id
    last = @all.last
    new_high = last.id.to_i
    new_high += 1
    new_high.to_s
  end

  def create(attributes)
    new_customer = Customer.new(attributes)
    @all << new_customer
  end

  def update(id, new_first_name, new_last_name)
    if find_by_id(id) != nil
      (find_by_id(id).first_name.clear.gsub!("", new_first_name))
      (find_by_id(id).last_name.clear.gsub!("", new_last_name))
    end
  end

  def delete(id)
    if find_by_id(id) != nil
      @all.delete(@all.find do |customer|
        customer.id == id
      end)
    end
  end
end
