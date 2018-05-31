module Repository

  def find_by_id(id)
    all.find {|object| object.id == id}
  end

  def find_all_by_customer_id(customer_id)
    all.find_all {|object| object.customer_id == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all {|object| object.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    all.find_all {|object| object.status == status}
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all {|object| object.invoice_id == invoice_id}
  end
end
