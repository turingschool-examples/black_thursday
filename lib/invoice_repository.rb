class InvoiceRepository 
  
  def initialize(info)
    @all = info
  end
  def find_all_by_status(search)
    status_array = []
    @all.find_all{|index| index.status.include?(search.downcase)}
    status_array << index
  end
  def find_all_by_merchant_id(search)
    merchant_id_array = []
    @all.find_all{|index| index.merchant_id.include?(search.downcase)}
    merchant_id_array << index
  end
  def find_all_by_customer_id(search)
    customer_id_array = []
    @all.find_all{|index| index.customer_id.include?(search.downcase)}
    customer_id_array << index
  end



end
