require 'csv'
require './lib/file_io'
require './lib/item'
require './lib/merchant'

describe FileIo do
  it 'exists' do
    file_io = FileIo.new

    expect(file_io).is_a? FileIo
  end

  it 'returns an array' do
    mock_row = {
      id: 12_345,
      name: 'Widget',
      description: 'Item desc',
      unit_price: '12.23',
      merchant_id: '12345'
    }

    allow(CSV).to receive(:foreach).and_yield(mock_row)

    mock_file_name = './some_file.csv'

    items = FileIo.process_csv(mock_file_name, Item)

    expect(items).to be_instance_of(Array)
    expect(items.first.id).to eq(12_345)
  end

  it 'can handle multiple rows' do
    filename = './data/merchants.csv'

    merch_ary = FileIo.process_csv(filename, Merchant)

    expect(merch_ary).is_a? Array
    expect(merch_ary.first).is_a?(Merchant)
  end
end
