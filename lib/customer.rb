# frozen_string_literal: true

# customer
class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repository

  def initialize(data, parent)
    @id                  = data[:id].to_i
    @first_name          = data[:first_name]
    @last_name           = data[:last_name]
    @created_at          = Time.parse(data[:created_at])
    @updated_at          = Time.parse(data[:updated_at])
    @customer_repository = parent
  end

  def change_first_name(name)
    @first_name = name
  end

  def change_last_name(name)
    @last_name = name
  end

  def change_updated_at
    @updated_at = Time.now
  end
end
