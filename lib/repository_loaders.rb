module RepositoryLoaders

  def load_items_into_repository(sales_engine, items)
    items.each do |row|
      @items.repository << Item.new(sales_engine, {:id =>row[:id],
                         :name => row[:name],
                         :description => row[:description],
                         :unit_price => row[:unit_price],
                         :merchant_id => row[:merchant_id],
                         :created_at => row[:created_at],
                         :updated_at => row[:updated_at]})
    end

  end

  def load_merchants_into_repository(sales_engine, merchants)
    merchants.each do |row|
      @merchants.repository << Merchant.new(sales_engine, {:id => row[:id],
                                             :name => row[:name],
                                             :created_at => row[:created_at],
                                             :updated_at => row[:updated_at]})
    end
  end

  def load_invoices_into_repository(sales_engine, invoices)
    invoices.each do |row|
      @invoices.repository << Invoice.new(sales_engine, {:id => row[:id],
                                          :customer_id => row[:customer_id],
                                          :merchant_id => row[:merchant_id],
                                          :status => row[:status],
                                          :created_at => row[:created_at],
                                          :updated_at => row[:updated_at]})
    end
  end

end
