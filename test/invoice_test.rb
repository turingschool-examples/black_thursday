require 'simplecov'
SimpleCov.start
require './lib/helper'

RSpec.describe Invoice do

  it 'exists' do
    invoice = Invoice.new({
      :id => 1,
      :merchant_id => 2,
      :customer_id => 143,
      :status => "pending",
      :created_at => Time.now,
      :updated_at => Time.now,
      })

    expect(invoice).to be_instance_of(Invoice)
  end

  # it 'returns id' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.id).to eq(1)
  # end
  #
  # it 'returns name' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.name).to eq("Pencil")
  # end
  #
  # it 'returns description' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.description).to eq("You can use it to write things")
  # end
  #
  # it 'returns unit price' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.unit_price).to eq(BigDecimal(10.99,4))
  # end
  #
  # xit 'returns time created' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.created_at).to eq(Time.now)
  #   #this doesn't pass because the expect is called slightlllllly after the object is inialized
  # end
  #
  # xit 'returns time updated' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.updated_at).to eq(Time.now)
  #   #this doesn't pass because the expect is called slightlllllly after the object is inialized
  # end
  #
  # it 'returns merchant id' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.merchant_id).to eq(2)
  # end
  #
  # it 'returns unit price in dollars' do
  #   invoice = Invoice.new({
  #     :id => 1,
  #     :name => "Pencil",
  #     :description => "You can use it to write things",
  #     :unit_price => BigDecimal(10.99,4),
  #     :created_at => Time.now,
  #     :updated_at => Time.now,
  #     :merchant_id => 2
  #     })
  #
  #   expect(invoice.unit_price_to_dollars).to eq(10.99)
  # end

end
