require 'rspec'
require './lib/invoice_item_repository'

describe InvoiceItemRepository do
  before (:each) do
    @invoice_item1 = double('item1')
    @invoice_item2 = double('item2')
    @invoice_item3 = double('item3')

    allow(@invoice_item1).to receive(:id){6}
    allow(@invoice_item1).to receive(:item_id){7}
    allow(@invoice_item1).to receive(:invoice_id){8}
    allow(@invoice_item1).to receive(:quantity){1}
    allow(@invoice_item1).to receive(:unit_price){BigDecimal(10.99, 4)}
    allow(@invoice_item1).to receive(:created_at){Time.now}
    allow(@invoice_item1).to receive(:updated_at){Time.now}

    allow(@invoice_item2).to receive(:id){9}
    allow(@invoice_item2).to receive(:item_id){10}
    allow(@invoice_item2).to receive(:invoice_id){11}
    allow(@invoice_item2).to receive(:quantity){1}
    allow(@invoice_item2).to receive(:unit_price){BigDecimal(20.99, 4)}
    allow(@invoice_item2).to receive(:created_at){Time.now}
    allow(@invoice_item2).to receive(:updated_at){Time.now}

    allow(@invoice_item3).to receive(:id){12}
    allow(@invoice_item3).to receive(:item_id){13}
    allow(@invoice_item3).to receive(:invoice_id){14}
    allow(@invoice_item3).to receive(:quantity){1}
    allow(@invoice_item3).to receive(:unit_price){BigDecimal(10.99, 4)}
    allow(@invoice_item3).to receive(:created_at){Time.now}
    allow(@invoice_item3).to receive(:updated_at){Time.now}
  end
  it 'exists' do
    iir = InvoiceItemRepository.new([@invoice_item1, @invoice_item2, @invoice_item3])
    expect(iir).to be_a(InvoiceItemRepository)
  end
  it 'can find_all_by_invoice id' do
    found = iir.find_all_by_invoice_id(11)
    expect(found).to eq(@invoice_item_2)
  end
end
