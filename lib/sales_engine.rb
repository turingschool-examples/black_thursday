require_relative 'merchant_repo'
require_relative 'item_repo'
require_relative 'invoice_repo'
require_relative 'invoice_item_repo'
require_relative 'transaction_repo'
require_relative 'customer_repo'

class SalesEngine
  attr_reader :merchant_repo,
              :item_repo,
              :invoice_repo,
              :invoice_item_repo,
              :transaction_repo,
              :customer_repo

  def self.from_csv(data_hash)
    new(data_hash)
  end

  def initialize(data_hash)
    @merchant_repo = MerchantRepo.new(data_hash[:merchants],self)
    @item_repo = ItemRepo.new(data_hash[:items],self)
    @invoice_repo = InvoiceRepo.new(data_hash[:invoices],self)
    @invoice_item_repo = InvoiceItemRepo.new(data_hash[:invoice_items],self)
    @transaction_repo = TransactionRepo.new(data_hash[:transactions],self)
    @customer_repo = CustomerRepo.new(data_hash[:customers],self)
  end

  def merchants
    merchant_repo
  end

  def items
    item_repo
  end

  def invoices
    invoice_repo
  end

  def invoice_items
    invoice_item_repo
  end

  def transactions
    transaction_repo
  end

  def customers
    customer_repo
  end

  def merchant_items(id)
    item_repo.find_all_by_merchant_id(id)
  end

  def item_merchant(id)
    merchant_repo.find_by_id(id)
  end

  def merchant_invoices(id)
    invoice_repo.find_all_by_merchant_id(id)
  end

  def invoice_merchant(id)
    merchant_repo.find_by_id(id)
  end

  def invoice_item_ids_list(id)
    list = invoice_item_repo.find_all_by_invoice_id(id)
    list.map { |i| i.item_id }
  end

  def invoice_items_list(id)
    invoice_item_ids_list(id).map { |i| self.items.find_by_id(i) }
  end

  def invoice_transactions(id)
    transaction_repo.find_all_by_invoice_id(id)
  end

  def invoice_customer(id)
    customer_repo.find_by_id(id)
  end

  def transaction_invoice(id)
    invoice_repo.find_by_id(id)
  end

  def merchant_customers(id)
    merchant_list = invoices.find_all_by_merchant_id(id)
    merchant_list.map { |invoice| invoice.customer }.uniq
  end

  def customer_merchants(id)
    customer_list = invoices.find_all_by_customer_id(id)
    customer_list.map { |invoice| invoice.merchant }.uniq
  end

  def total(id)
    return 0 if !invoices.find_by_id(id).is_paid_in_full?
    selected_invoices = invoice_items.find_all_by_invoice_id(id)
    selected_invoices.reduce(0) do |sum, invoice_item|
      sum +=(invoice_item.quantity * invoice_item.unit_price)
    end
  end

  def merchants_by_total_revenue
    merchants.merchants_by_total_revenue
  end

  def revenue_by_merchant(merchant_id)
    merchants.revenue_by_merchant(merchant_id)
  end

  def most_sold_item_for_merchant(merchant_id)
    invoice_list = invoices.find_all_by_merchant_id(merchant_id)
    paid_invoices = invoice_list.select { |inv| inv.is_paid_in_full? }
    inv_items = paid_invoices.map { |ii| ii.invoice_items }
    turn_to_items(top_item(inv_items))
  end

  def top_item(inv_items)
    max = inv_items.flatten.max_by { |ii| ii.quantity }
    inv_items.flatten.select do |ii|
      ii.quantity == max.quantity
    end
  end

  def turn_to_items(top_item)
    top_item.flatten.map do |ii|
      items.find_by_id(ii.item_id)
    end
  end

  def invoice_items_for_invoice(id)
    invoice_items.find_all_by_invoice_id(id)
  end

  def best_item_for_merchant(merchant_id)
    merchant = merchants.find_by_id(merchant_id)
    paid_invoices = merchant.invoices.select { |inv| inv.is_paid_in_full? }
    paid_iis = paid_invoices.map { |inv| inv.invoice_items }.flatten
    id_p_array = paid_iis.map { |ii| [ii.id, ii.prices] }
    max_by_p = id_p_array.max_by { |ii| ii[1] }
    ii_id = max_by_p[0]
    ii = invoice_items.find_by_id(ii_id).item_id
    items.find_by_id(ii)
  end

end
