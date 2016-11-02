require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require 'time'
require 'csv'

class SalesEngine

  def self.from_csv(files)
    @merchant_repo = create_merchant_repository(files)
    @item_repo = create_item_repository(files)
    @invoice_repo = create_invoice_repository(files)
    self
  end

  def self.create_item_repository(files)
    if files.include?(:items)
      ItemRepository.new(item_csv_parse(files[:items]))
    end
  end

  def self.items
    @item_repo
  end

  def self.create_merchant_repository(files)
    if files.include?(:merchants)
      MerchantRepository.new(merchant_csv_parse(files[:merchants]))
    end
  end

  def self.merchants
    @merchant_repo
  end

  def self.create_invoice_repository(files)
    if files.include?(:invoices)
      InvoiceRepository.new(invoice_csv_parse(files[:invoices]))
    end
  end

  def self.invoices
    @invoice_repo
  end

  def self.item_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Item.new({:id => row[:id].to_i,
                :name => row[:name],
                :unit_price => BigDecimal(row[:unit_price]) / 100,
                :created_at => Time.parse(row[:created_at]),
                :updated_at => Time.parse(row[:updated_at]),
                :merchant_id => row[:merchant_id].to_i,
                :description => row[:description]
              })
    end
  end
  
  def self.merchant_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Merchant.new({:id => row[:id].to_i, :name => row[:name]})
    end
  end

  def self.invoice_csv_parse(file)
    contents = CSV.open file, headers: true, header_converters: :symbol
    contents.map do |row|
      Invoice.new({ :id => row[:id].to_i,
                    :customer_id => row[:customer_id].to_i,
                    :merchant_id => row[:merchant_id].to_i,
                    :status => row[:status],    
                    :created_at => Time.parse(row[:created_at]),
                    :updated_at => Time.parse(row[:updated_at])
                 })
    end
  end

end