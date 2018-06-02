require_relative 'customer.rb'
require_relative 'repo_methods.rb'

class CustomerRepository
  include RepoMethods
  attr_reader :collection

  def initialize(data_from_csv)
    @collection = get_data_from_csv(data_from_csv)
  end

  def get_data_from_csv(data_from_csv)
    data_from_csv.map do |line|
      [line[:id].to_i, Customer.new(line)]
    end.to_h
  end

  def create(attributes)
    attributes[:id] = new_id
    @collection[new_id] = Customer.new(attributes)
  end

  def update(current_id, new_attributes)
    if @collection[current_id] == nil
    else
      @collection[current_id].update_first_name(new_attributes) if new_attributes[:first_name]
      @collection[current_id].update_last_name(new_attributes) if new_attributes[:last_name]
      @collection[current_id].update_updated_at(Time.now)
    end
  end

  def find_all_by_first_name(name_fragment)
    all.reduce([]) do |collector, element|
      if element.first_name.downcase.include?(name_fragment.downcase)
        collector << element
      end
      collector
    end
  end

  def find_all_by_last_name(name_fragment)
    all.reduce([]) do |collector, element|
      if element.last_name.downcase.include?(name_fragment.downcase)
        collector << element
      end
      collector
    end
  end

end
