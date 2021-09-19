require "CSV"
require_relative "../lib/invoice"
require "Time"
require_relative '../lib/repo_module'


class InvoiceRepo
  include Repo
  attr_reader :all

  def initialize(path)
    @path = path
    @all = to_array
  end

  def create_array_of_objects
    @things.map do | invoice |
      Invoice.new(invoice)
    end
  end

  def find_all_by_customer_id(customer_id)
    all.select do | invoice |
      customer_id == invoice.customer_id
    end
  end

  def find_all_by_status(status)
    all.select do | invoice |
      status == invoice.status
    end
  end

  def create(attributes)
    id = find_highest_id + 1
    current_time = Time.now.strftime("%F")
    attributes = {
      id: id.to_s,
      status: attributes[:status],
      customer_id: attributes[:customer_id].to_s,
      merchant_id: attributes[:merchant_id].to_s,
      created_at: current_time,
      updated_at: current_time
    }
    @all << Invoice.new(attributes)
  end

  def update(id, attributes)
    find_by_id(id).change_status(attributes[:status])
  end

end
