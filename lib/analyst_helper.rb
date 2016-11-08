module AnalystHelper

  def decimal(number)
    BigDecimal.new(number)
  end

  def format(number)
    number.round(2).to_f
  end
  
  def price_compiler(id)
    merchant_items = sales_engine.find_all_items_by_merchant_id(id)
    no_prices                  if merchant_items.size == 0
    all_prices(merchant_items) if merchant_items.size > 0
  end

  def no_prices
    prices = [0]
  end

  def all_prices(merchant_items)
    merchant_items.map { |item| item.unit_price }
  end

  def empty(collection)
    collection == nil
  end

  def single(collection)
    collection.size == 1
  end

  def big(collection)
    collection.reduce(&:+).to_f / collection.size.to_f
  end

  def days_of_the_week
    days = Hash.new(0)
    @invoices.each do |invoice|
      days["Sunday"]    += 1 if invoice.created_at.sunday?
      days["Monday"]    += 1 if invoice.created_at.monday?
      days["Tuesday"]   += 1 if invoice.created_at.tuesday?
      days["Wednesday"] += 1 if invoice.created_at.wednesday?
      days["Thursday"]  += 1 if invoice.created_at.thursday?
      days["Friday"]    += 1 if invoice.created_at.friday?
      days["Saturday"]  += 1 if invoice.created_at.saturday?
    end
    days
  end

end

