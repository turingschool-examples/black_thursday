require 'csv'
require 'pry'
require 'time'

module CSVReader
  def self.parse_merchants(mr, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        mr.add_merchant(Merchant.new({:id => row[0].to_i, :name => row[1], :created_at => Time.parse(row[2]),
          :updated_at => Time.parse(row[3])}))
      else
        skip_first_line = false
      end
    end
    mr
  end

  def self.parse_items(ir, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        ir.add_item(Item.new({:id => row[0].to_i, :name => row[1],
              :description => row[2], :unit_price => (BigDecimal.new(row[3],row[3].length)/100),
              :created_at => Time.parse(row[5]),
              :updated_at => Time.parse(row[6]),
              :merchant_id => row[4].to_i}))
      else
        skip_first_line = false
      end
    end
    ir
  end

  def self.parse_invoices(inr, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        inr.add_invoice(Invoice.new({:id => row[0].to_i, :customer_id => row[1].to_i,
              :merchant_id => row[2].to_i, :status => row[3].to_sym,
              :created_at => Time.parse(row[4]),
              :updated_at => Time.parse(row[5])}))
      else
        skip_first_line = false
      end
    end
    inr
  end

  def self.parse_invoice_items(iir, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        iir.add_invoice_item(InvoiceItem.new({:id => row[0].to_i, :item_id => row[1].to_i,
              :invoice_id => row[2].to_i, :quantity => row[3].to_i,
              :unit_price => BigDecimal(row[4], row[4].length)/100,
              :created_at => Time.parse(row[5]),
              :updated_at => Time.parse(row[6])}))
      else
        skip_first_line = false
      end
    end
    iir
  end

  def self.parse_transactions(tr, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        tr.add_transaction(Transaction.new({:id => row[0].to_i, :invoice_id => row[1].to_i,
              :credit_card_number => row[2], :credit_card_expiration_date => row[3],
              :result => row[4].to_sym,
              :created_at => Time.parse(row[5]),:updated_at=> Time.parse(row[6])}))
      else
        skip_first_line = false
      end
    end
    tr
  end

  def self.parse_customers(cr, file_path)
    skip_first_line = true
    CSV.foreach(file_path) do |row|
      unless skip_first_line
        cr.add_customer(Customer.new({:id => row[0].to_i, :first_name => row[1],
              :last_name => row[2], :created_at => Time.parse(row[3]),
              :updated_at => Time.parse(row[4])}))
      else
        skip_first_line = false
      end
    end
    cr
  end

end
