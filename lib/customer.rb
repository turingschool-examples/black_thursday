require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :customer_repo

  def initialize(customer)
   @id   = customer[:id].to_i
   @first_name = customer[:first_name]
   @last_name = customer[:last_name]
   @created_at = Time.parse(customer[:created_at])
   @updated_at = Time.parse(customer[:updated_at])
   @customer_repo = customer[:customer_repo]
  end

  def self.creator(row, parent)
    new({
      id: row[:id],
      first_name: row[:first_name],
      last_name: row[:last_name],
      created_at: row[:created_at],
      updated_at: row[:updated_at],
      customer_repo: parent
    })
  end

  def invoices
    customer_repo.find_all_invoices_by_id(id)
  end

  def merchants
    invoices.map(&:merchants).uniq
  end

end
