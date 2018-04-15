class module
  def invoices_for_merchant(id)
    @parent.find_all_by_merchant_id(id)
  end
end
