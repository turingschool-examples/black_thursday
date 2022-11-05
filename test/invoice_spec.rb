require 'simplecov'
SimpleCov.start
require 'rspec'
require 'pry'
require './lib/invoice'

RSpec.describe Invoice do

  it 'invoice exists and has attributes' do
   invoice = Invoice.new

   expect(invoice).to be_instance_of(Invoice)
  end

end
