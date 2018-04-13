# frozen_string_literal: true

# Module with funtions to help search objects.
module RepositoryHelper
  def all
    @repository
  end

  def find_by_id(id)
    @id[id].first unless @id[id].nil?
  end

  def find_all_by_merchant_id(merchant_id)
    @merchant_id[merchant_id]
  end

  def find_all_by_customer_id(cust_id)
    @customer_id[cust_id]
  end

  def find_all_by_created_at(date)
    @created_at[date]
  end

  def find_by_created_at(date)
    @created_at[date].first unless @created_at[date].nil?
  end

  def find_all_by_invoice_id(invoice_id)
    @invoice_id[invoice_id]
  end
end
