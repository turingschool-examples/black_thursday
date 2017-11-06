require "time"

class Customer
  attr_reader :id,
              :first_name
              :last_name
              :created_at
              :updated_at
              :repository

  def initialize(item_info, parent)
    @id           = item_info[:id].to_i
    @first_name   = item_info[:first_name]
    @last_name    = item_info[:last_name]
    @created_at   = Time.parse(item_info[:created_at])
    @updated_at   = Time.parse(item_info[:updated_at])
    @repository   = parent
  end

  def merchant
    @repository.find_merchant(self.merchant_id)
  end

end
