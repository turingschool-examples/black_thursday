require 'csv'

module Parser

  def parse_merchants_csv(file_path)
    data = [] 
    CSV.foreach(file_path, headers:true) do |row|
      data << {:id => row['id'],
               :name => row['name'],
               :created_at => row['created_at']}
    end
    data
  end

  def parse_items_csv(file_path)
    items_data = []
    CSV.foreach(file_path, headers:true) do |row|
      items_data << {:id => row['id'], 
                      :name => row['name'],
                      :description => row['description'],
                      :unit_price => row['unit_price'],
                      :merchant_id => row['merchant_id'],
                      :created_at => Time.parse(row['created_at']),
                      :updated_at => Time.parse(row['updated_at'])}
    end
    items_data
  end

  def parse_invoices_csv(file_path)
    invoice_data = []
    CSV.foreach(file_path, headers:true) do |row|
      invoice_data << { :id => row['id'],
                        :customer_id => row['customer_id'],
                        :merchant_id => row['merchant_id'],
                        :status => row['status'],
                        :created_at => Time.parse(row['created_at']),
                        :updated_at => Time.parse(row['updated_at'])}
    end
    invoice_data
  end

  def parse_customers_csv(file_path)
    customer_data = []
    CSV.foreach(file_path, headers:true) do |row|
      customer_data << {:id => row['id'],
                        :first_name => row['first_name'],
                        :last_name  => row['last_name'],
                        :created_at => row['created_at'],
                        :updated_at => row['updated_at']}
    end
    customer_data
  end

  def parse_invoice_items_csv(file_path)
    invoice_item_data = []
    CSV.foreach(file_path, headers:true) do |row|
      invoice_item_data << {:id => row['id'],
                        :item_id    => row['item_id'],
                        :invoice_id => row['invoice_id'],
                        :unit_price => row['unit_price'],
                        :quantity   => row['quantity'],
                        :created_at => row['created_at'],
                        :updated_at => row['updated_at']}
    end
    invoice_item_data
  end

  def parse_transactions_csv(file_path)
    transaction_data = []
    CSV.foreach(file_path, headers:true) do |row|
      transaction_data << { :id => row['id'],
                            :invoice_id => row['invoice_id'],
                            :credit_card_number => row['credit_card_number'],
                            :credit_card_expiration_date => row['credit_card_expiration_date'],
                            :result => row['result'],
                            :created_at => row['created_at'],
                            :updated_at => row['updated_at']}
    end
    transaction_data
  end

end