# frozen_string_literal: true

# stores methods used for sales analyst
module SalesRelationships
  def find_all_items_by_merchant_id(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_all_invoices_by_merchant_id(merchant_id)
    invoices.find_all_by_merchant_id(merchant_id)
  end
end
