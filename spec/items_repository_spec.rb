require 'rspec'
require './lib/items_repository'

describe ItemsRepository do
  before(:each) do
    @ir = ItemsRepository.new("./data/items.csv")
  end

  it "exists" do
    expect(@ir).to be_an_instance_of(ItemsRepository)
  end

  it 'lists all items' do
    expect(@ir.all).to eq(@ir.repository)
  end

  it 'can find an item by the id' do
    item = @ir.find_by_id("263395237")
    expect(item.name).to eq("510+ RealPush Icon Set")
    expect(item.unit_price).to eq("1200")
  end

  it 'can find an item by the name' do
    item = @ir.find_by_name("510+ RealPush Icon Set")
    expect(item.id).to eq("263395237")
    expect(item.unit_price).to eq("1200")
  end

  it 'can find an item by description' do
    item = @ir.find_by_description("Acrylique sur toile exécutée en 2011
    Format : 65 x 54 cm
    Toile sur châssis en bois - non encadré
    Artiste : Flavien Couche - Artiste côté Akoun

    TABLEAU VENDU AVEC FACTURE ET CERTIFICAT D&#39;AUTHETICITE

    www.flavien-couche.com")
    
    expect(item.id).to eq("263398179")
    expect(item.unit_price).to eq("50000")
  end
end
