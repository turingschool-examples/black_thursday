require 'csv'

module Parser

  def parse_merchants_csv(file_path)
    data = [] 
    CSV.foreach(file_path, headers:true) do |row|
      data << {:id => row['id'],
               :name => row['name']}
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

end