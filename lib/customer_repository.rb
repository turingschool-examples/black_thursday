# frozen_string_literal: true

require_relative 'repository'
class CustomerRepository < Repository

  def find_all_by_first_name(name_to_search)
    @all.select do |customer|
      customer.first_name.downcase.include?(name_to_search.downcase)
    end
  end

  def find_all_by_last_name(name_to_search)
    @all.select do |customer|
      customer.last_name.downcase.include?(name_to_search.downcase)
    end
  end

  def update(id, attributes)
    sanitized_attributes = {
      first_name: attributes[:first_name],
      last_name: attributes[:last_name],
      updated_at: Time.now
    }
    super(id, sanitized_attributes)
  end
end