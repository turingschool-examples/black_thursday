require_relative '../lib/parsable'

RSpec.describe Parsable do
  include Parsable

  it 'parse csv merchants' do
    expect(parse_csv("./data/merchants.csv")).to be_instance_of(Array)
  end

  it 'parse csv items' do
    expect(parse_csv("./data/items.csv")).to be_instance_of(Array)
  end

  it 'creates hashes' do
    expect(parse_csv("./data/merchants.csv")[0]).to be_instance_of(Hash)
  end

end
