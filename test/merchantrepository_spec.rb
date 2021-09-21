require 'rspec'
require 'csv'
require './lib/merchant'
require './lib/merchantrepository'
require './lib/sales_engine'

RSpec.describe 'MerchantRepository' do

  xit "can find a merchant by ID number" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr).to be_a(MerchantRepository)
    expect(mr.find_by_id(12334146).id).to eq(12334146)
    expect(mr.find_by_id(12334146).name).to eq("MotankiDarena")
  end

  xit 'can find a merchant by name' do

    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr.find_by_name("Shopin1901").name).to eq("shopin1901")
    expect(mr.find_by_name("FANCYBOOKART").name).to eq("fancybookart")
  end

  xit 'finds all by name' do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr.find_all_by_name("Georgia").first.name).to eq("GEORGIAFAYEDESIGNS")
    expect(mr.find_all_by_name("shop")[2].name).to eq("WOODENPENSHOP")
  end

  it 'creates' do
    se = SalesEngine.new({ :items => "./data/items.csv",
                      :merchants => "./data/merchants.csv"
                      })
    mr = se.merchants


    attributes = {
                  :id    => 12337412,
                  :name  => "Turing School of Software and Design"
                }

    expect(mr.all.length).to eq(475)
    mr.create(attributes)
    expect(mr[0].name).to eq([])
    expect(mr.all.length).to eq(476)


    # se = SalesEngine.from_csv({
    #   :items     => "./data/items.csv",
    #   :merchants => "./data/merchants.csv",
    # })
    # mr = se.merchants
    # mr.create("OurStore", "2020-12-10", "2021-03-20")
    #
    # expect(mr.find_by_id(12337413).name).to eq("OurStore")
  end

  it "can update the name of merchants" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    expect(mr.update(12334149, "Bluebow").name).to eq("Bluebow")

  end

  it "can delete merchants" do
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants

    mr.delete(12337413)

    expect(mr.find_by_id(12337413)).to eq(nil)
  end
end
