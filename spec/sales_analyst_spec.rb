require './spec/spec_helper'

RSpec.describe SalesAnalyst do
  let (:item_1) {Item.new({:id => 1,
                   :name => "Shoes",
                   :description => "left shoe, right shoe",
                   :unit_price => BigDecimal(78.54,4),
                   :created_at => Time.now,
                   :updated_at => Time.now,
                   :merchant_id => 1})}
  let (:item_2) {Item.new({:id => 2,
                    :name => "Cool hat",
                    :description => "black top hat",
                    :unit_price => BigDecimal(22.24,4),
                    :created_at => Time.now,
                    :updated_at => Time.now,
                    :merchant_id => 2})}
  let (:item_3) {Item.new({:id => 3,
                    :name => "More Expensive Cool hat",
                    :description => "black top hat",
                    :unit_price => BigDecimal(32.44,4),
                    :created_at => Time.now,
                    :updated_at => Time.now,
                    :merchant_id => 2})}
  let (:items) {[item_1, item_2, item_3]}
  let (:item_repo) {ItemRepository.new(items)}
  let (:merchant_1) {Merchant.new({:id => 1,
                             :name => "Nike"})}
  let (:merchant_2) {Merchant.new({:id => 2,
                             :name => "Addidas"})}
  let (:merchants) {[merchant_1, merchant_2]}
  let (:merchant_repo) {MerchantRepository.new(merchants)}
  let (:invoice_1) {Invoice.new({:id => 1,
                      :customer_id => 1,
                      :merchant_id => 1,
                      :status => :pending,
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:invoice_2) {Invoice.new({:id => 2,
                      :customer_id => 2,
                      :merchant_id => 1,
                      :status => :pending,
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:invoice_3) {Invoice.new({:id => 3,
                      :customer_id => 1,
                      :merchant_id => 2,
                      :status => :shipped,
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:invoices) {[invoice_1, invoice_2, invoice_3]}
  let (:invoice_repo) {InvoiceRepository.new(invoices)}
  let (:invoice_item_1) {InvoiceItem.new({:id => 1,
                      :item_id => 1,
                      :invoice_id => 1,
                      :quantity => 5,
                      :unit_price => BigDecimal(78.54,4),
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:invoice_item_2) {InvoiceItem.new({:id => 2,
                      :item_id => 2,
                      :invoice_id => 2,
                      :quantity => 4,
                      :unit_price => BigDecimal(22.24,4),
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:invoice_item_3) {InvoiceItem.new({:id => 3,
                      :item_id => 3,
                      :invoice_id => 3,
                      :quantity => 6,
                      :unit_price => BigDecimal(32.44,4),
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:invoice_items) {[invoice_item_1, invoice_item_2, invoice_item_3]}
  let (:invoice_item_repo) {InvoiceItemRepository.new(invoice_items)}
  let (:transaction_1) {Transaction.new({:id => 1,
                      :invoice_id => 1,
                      :credit_card_number => "2424242424242424",
                      :credit_card_expiration_date => "0424",
                      :result => "success",
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:transaction_2) {Transaction.new({:id => 2,
                      :invoice_id => 2,
                      :credit_card_number => "2424242424242424",
                      :credit_card_expiration_date => "0424",
                      :result => "failed",
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:transaction_3) {Transaction.new({:id => 3,
                      :invoice_id => 3,
                      :credit_card_number => "2424242424242424",
                      :credit_card_expiration_date => "0424",
                      :result => "failed",
                      :created_at => Time.now,
                      :updated_at => Time.now})}
  let (:transactions) {[transaction_1, transaction_2, transaction_3]}
  let (:transaction_repo) {TransactionRepository.new(transactions)}
  let (:sales_analyst) {SalesAnalyst.new(item_repo, merchant_repo, invoice_repo, invoice_item_repo, transaction_repo)}
  
  describe 'iteration 1' do
    it 'exists' do
      expect(sales_analyst).to be_a(SalesAnalyst)
    end

    it '#item_count can determine how many total items are available' do
      expect(sales_analyst.item_count).to eq(3)
    end

    it '#items_per_merchant() can determine how many products individual merchants sell' do
      expect(sales_analyst.items_per_merchant(1)).to eq(1)
      expect(sales_analyst.items_per_merchant(2)).to eq(2)
    end

    it '#merchant_count can count the total number of merchants' do
      expect(sales_analyst.merchant_count).to eq(2)
    end

    it '#average_items_per_merchant can determine how many products merchants sell on average' do
      expect(sales_analyst.average_items_per_merchant).to eq(1.5)
    end

    it '#average_items_per_merchant_standard_deviation can determine standard deviation on average items per merchant' do
      expect(sales_analyst.average_items_per_merchant_standard_deviation).to eq(0.71)
    end

    it '#merchants_with_high_item_count can determine which merchants sell the highest number of items' do
      expect(sales_analyst.merchants_with_high_item_count).to eq([])
    end


    it '#average_average_price_per_merchant can determine the average price of an item across all merchants' do
      expect(sales_analyst.average_item_price_for_merchant(1)).to eq(0.7854e2.to_d)
    end

    it '#average_average_price_per_merchant can determine the average price of an item across all merchants' do
      expect(sales_analyst.average_average_price_per_merchant).to eq( 0.5294e2)
    end

    it '#golden_items can determine which items are 2 standard deviations above the avg item price' do
      expect(sales_analyst.golden_items).to eq([])
    end
  end

  describe 'iteration 2' do
    it '#invoice_quantity_per_merchant returns an array with correct invoice quantity values' do
      expect(sales_analyst.invoice_quantity_per_merchant).to eq([1, 2])
    end

    it '#merchant_invoice_num returns how many invoices a merchant has' do
      expect(sales_analyst.merchant_invoice_num(1)).to eq(2)
      expect(sales_analyst.merchant_invoice_num(2)).to eq(1)
    end

    it '#average_invoices_per_merchant correctly calculates and returns the average invoices per merchant' do
      expect(sales_analyst.average_invoices_per_merchant).to eq(1.5)
    end

    it '#average_invoices_per_merchant_standard_deviation calculates and returns the correct value' do
      expect(sales_analyst.average_invoices_per_merchant_standard_deviation).to eq(0.5)
    end

    it '#top_merchants_by_invoice_count returns array of merchant objects 2 standard deviations above the mean' do
      expect(sales_analyst.top_merchants_by_invoice_count).to eq([])
    end

    it '#bottom_merchants_by_invoice_count returns array of merchant objects 2 standard deviations below the mean' do
      expect(sales_analyst.bottom_merchants_by_invoice_count).to eq([])
    end

    it '#top_days_by_invoice_count returns and array of days one standard deviation above the mean' do
      expect(sales_analyst.top_days_by_invoice_count).to eq([])
    end

    it '#invoice_status returns the % of invoices with the passed in status' do
      expect(sales_analyst.invoice_status(:pending)).to eq(66.67)
      expect(sales_analyst.invoice_status(:shipped)).to eq(33.33)
      expect(sales_analyst.invoice_status(:returned)).to eq(0.0)
    end
  end

  describe 'iteration 3' do
    xit '#invoice_paid_in_full? returns true if transaction is successful, false otherwise' do
      expect(sales_analyst.invoice_paid_in_full?(1)).to eq(true)
      expect(sales_analyst.invoice_paid_in_full?(2)).to eq(false)
      expect(sales_analyst.invoice_paid_in_full?(3)).to eq(false)
    end

    it '#invoice_total returns the total $ of the invoice' do
      expect(sales_analyst.invoice_total(1)).to eq(5 * BigDecimal(78.54,4))
      expect(sales_analyst.invoice_total(2)).to eq(4 * BigDecimal(22.24,4))
      expect(sales_analyst.invoice_total(3)).to eq(6 * BigDecimal(32.44,4))
    end
  end
  describe 'iteration 4' do
    it '#total_revenue_by_date' do
      expect(sales_analyst.total_revenue_by_date("2022-11-07")).to eq(133.22)
    end
  end
end
