# frozen_string_literal: true

require './lib/invoice_repo'
require './lib/invoice'
require 'CSV'

RSpec.describe InvoiceRepo do
  let(:data){ CSV.readlines('./data/invoices_test.csv', headers: true, header_converters: :symbol) }
  let(:engine) { 'Empty_SE' }
  let(:ir) { InvoiceRepo.new(data, engine) }
  let(:invoice1) { ir.repository[0] }
  let(:invoice2) { ir.repository[1] }
  let(:invoice3) { ir.repository[2] }
  let(:invoice4) { ir.repository[3] }
  let(:invoice5) { ir.repository[4] }

  describe '#initialize' do
    it 'exists' do
      expect(ir).to be_a InvoiceRepo
    end
  end

  describe '#all' do
    it 'returns an array of all known Invoice instances' do
      expect(ir.all).to eq [invoice1, invoice2, invoice3, invoice4, invoice5]
    end
  end

  describe '#find_by_id' do
    it 'returns either nil or an instance of Invoice with matching id' do
      expect(ir.find_by_id(3)).to eq invoice3
      expect(ir.find_by_id(8)).to eq nil
    end
  end

  describe '#find_all_by_customer_id' do
    it 'returns either [] or one or more instances of Invoice with matching customer id' do
      expect(ir.find_all_by_customer_id(231)).to eq []
      expect(ir.find_all_by_customer_id(1)).to eq [invoice1, invoice2, invoice3, invoice4, invoice5]
    end
  end

  describe '#find_all_by_merchant_id' do
    it 'returns either [] or one or more instances of Invoice with matching merchant id' do
      expect(ir.find_all_by_merchant_id(12_335_938)).to eq [invoice1]
      expect(ir.find_all_by_merchant_id(33_333_333)).to eq []
    end
  end

  describe '#find_all_by_status' do
    it 'returns [] or one or more instances of Invoice with matching status' do
      expect(ir.find_all_by_status(:pending)).to eq [invoice1, invoice4, invoice5]
      expect(ir.find_all_by_status(:shipped)).to eq [invoice2, invoice3]
    end
  end

  describe '#invoice_status' do
    it 'returns an float representing the percent of matches to status type symbol passed' do
      expect(ir.invoice_status(:shipped)).to eq 40.0
      expect(ir.invoice_status(:shipped)).to be_a Float
      expect(0..100).to include(ir.invoice_status(:shipped))
    end
  end

  describe '#create' do
    it 'creates an Invoice with the provided attributes, new id is current highest + 1' do
      expect(ir.create({
                        customer_id:         7,
                        merchant_id:         8,
                        status:      :pending,
                        created_at:   Time.now,
                        updated_at:   Time.now
                       }).id).to eq 6
    end
  end

  describe '#update' do
    it 'updates Invoice with corresponding id with the provided attributes' do
      expect(ir.repository[0].status).to eq :pending
      ir.update('1', { status: :shipped })
      expect(ir.repository[0].status).to eq :shipped
      expect(ir.repository[0].updated_at).to be_within(0.5).of Time.now
    end
  end

  describe '#delete' do
    it 'deletes the Invoice instance with corresponding id' do
      ir.delete('1')
      expect(ir.repository.count).to eq(4)
      expect(ir.repository[0].id).to eq(2)
    end
  end

  describe '#convert_int_to_day(num)' do
    it 'converts an integer numeric value into a string weekday' do
      expect(ir.convert_int_to_day(3)).to eq('Wednesday')
      expect(ir.convert_int_to_day(7)).to eq(nil)
    end
  end

  describe '#number_of_invoices_per_day' do
    it 'returns a hash containing invoice counts by a dayname=>count structure' do
      expect(ir.number_of_invoices_per_day.keys).to eq(
        ["Saturday", "Friday", "Wednesday", "Monday"]
      )
      expect(ir.number_of_invoices_per_day.values).to eq([2, 1, 1, 1])
    end
  end

  describe '#average_invoices_per_day' do
    it 'returns the average number of invoices per day' do
      engine = double('engine')
      invoices = double('invoice_repo')
      allow(ir).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoices).and_return(invoices)

      expect(ir.average_invoices_per_day).to eq(1.25)
    end
  end

  describe '#average_invoices_per_day_standard_deviation' do
    it 'returns the deviation for average number of invoices per day' do
      engine = double('engine')
      invoices = double('invoice_repo')
      allow(ir).to receive(:engine).and_return(engine)
      allow(engine).to receive(:invoices).and_return(invoices)

      expect(ir.average_invoices_per_day_standard_deviation).to eq(0.5)
    end
  end

  describe '#top_days_by_invoice_count' do
    it 'returns a collection of all days that are above the average by one std deviation' do
      expect(ir.top_days_by_invoice_count).to eq(['Saturday'])
    end
  end

  describe '#invoice_paid_in_full?' do
    it 'returns a boolean indicating whether or not an invoice has been paid' do
      allow(invoice1).to receive(:paid?).and_return(true)
      allow(invoice2).to receive(:paid?).and_return(false)

      expect(ir.invoice_paid_in_full?(1)).to be true
      expect(ir.invoice_paid_in_full?(2)).to be false
    end
  end

  describe '#invoice_total' do
    it 'returns the total dollar value of an Invoice' do
      allow(invoice1).to receive(:total).and_return(1000)

      expect(ir.invoice_total(1)).to eq 1000
    end
  end
end
