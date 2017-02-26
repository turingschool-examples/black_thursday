require 'time'
require 'date'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repo

  def initialize(row, repo)
    @id = row[:id].to_i
    @customer_id = row[:customer_id].to_i
    @merchant_id = row[:merchant_id].to_i
    @status = row[:status].to_sym
    @created_at = Time.parse(row[:created_at])
    @updated_at = Time.parse(row[:updated_at])
    @repo = repo
  end

  def merchant
    repo.sales_engine.merchants.find_by_id(self.merchant_id)
  end

  def day_of_the_week_on_which_an_invoice_is_created
    @created_at.strftime('%A')
  end

  def items
    total = repo.sales_engine.invoice_items.find_all_by_invoice_id(self.id)
    #we now have a bunch of invoices in an array
    #find_all corresponding item ids

    item_ids = total.each { |invoice_item| puts invoice_item.item_id  }
    #we have an array of item ids
    #we want to return the instance of item associated with each of these numbers
    # go into the item repo and pick out each instance that has the
    item_ids.each do |item_id|
  # give me the intance of Item associted with the id



  end


  def transactions
    repo.sales_engine.transactions.find_all_by_invoice_id(self.id)
  end

  def customer
    repo.sales_engine.customers.find_by_id(self.customer_id)
  end

end
