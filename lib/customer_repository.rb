# frozen_string_literal: true

require_relative 'repository'
class CustomerRepository < Repository

  def find_all_by_first_name(name_to_search)
    @all.select do |customer|
      customer.first_name.downcase.include?(name_to_search.downcase)
    end
  end
end