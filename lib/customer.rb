require 'time'

class Customer

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :parent

  def initialize(item_info = nil, repo = nil)
    return if item_info.to_h.empty?
    @parent      = repo
    @id          = item_info[:id].to_i
    @first_name  = item_info[:first_name].to_s
    @last_name   = item_info[:last_name].to_s
    @created_at  = Time.parse(item_info[:created_at].to_s)
    @updated_at  = Time.parse(item_info[:updated_at].to_s)
  end

  def merchants
    parent.find_merchants_of_customer(id)
  end

end
