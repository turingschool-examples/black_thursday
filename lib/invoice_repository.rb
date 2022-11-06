require_relative 'repository'

class InvoiceRepository < Repository
  def find_all_by_customer_id(id)
    @all.select do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_status(status)
    @all.select do |invoice|
      invoice.status == status
    end
  end
end