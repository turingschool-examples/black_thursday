require_relative '../lib/merchant_repository'
require_relative 'spec_helper'
require 'pry'

RSpec.describe MerchantRepository do

  before(:each) do
      @merchant1  = Merchant.new({id: "12334105",
                              name: "Shopin1901",
                              created_at: "2010-12-10",
                              updated_at: "2011-12-04"
                  })
      @merchant2 = Merchant.new({id: "12334106",
                              name: "Shopin1901",
                              created_at: "2010-12-10",
                              updated_at: "2011-12-04"
                  })

      @merchants = MerchantRepository.new([@merchant1, @merchant2])
  end



  it "exist" do
    expect(@merchants).to be_a(MerchantRepository)
  end

  it "holds #all merchant data" do
    # binding.binding.pry
    expect(@merchants.all.count).to eq(2)
  end

end
