require_relative 'similar_attributes'

class MerchantGenerator
  attr_accessor :id, :name, :created_at, :updated_at

  def initialize
    @counter = 0
    @id = id
    @name = name
    @created_at = created_at
    @updated_at = updated_at
  end

MERCH_NAMES = ["", "Shopin1901",
  "Candisart",
  "MiniatureBikez",
  "LolaMarleys",
  "Keckenbauer",
  "perlesemoi",
  "jejum",
  "Urcase17",
  "MotankiDarena",
  "TheLilPinkBowtique",
  "DesignerEstore",
  "byMarieinLondon",
  "JUSTEmonsters",
  "Uniford",
  "thepurplepenshop",
  "handicraftcallery",
  "Madewithgitterxx",
  "JacquieMann",
  "TheHamAndRat",
  "Lnjewelscreation",
  "FlavienCouche",
  "VectorCoast",
  "BloominScents",
  "GJGemology",
  "MuttisStrickwaren",
  "CottonBeeWraps",
  "Snewzy",
  "ElisabettaComotto",
  "Hatsbybz",
  "Princessfrankknits",
  "WellnessNeelsen",
  "GiftOfFelt",
  "Corbeilwood",
  "Woodenpenshop",
  "esellermart",
  "LunaGuatemala",
  "FlyingLoaf",
  'TeeTeeTieDye',
  "TheAssemblyRooms",
  "BrattyGirlGems"]

  def id_setter
    @id = merchant_ids.sample(1).join.to_i
  end

  def name_setter
    @name = MERCH_NAMES[counter]
  end

  def created_at_setter
    @created_at = created_at_updated_at.sample(1).join
  end

  def updated_at_setter
    @updated_at = created_at_updated_at.sample(1).join
  end

  def output
    puts "#{@id_setter}, #{@name_setter}, #{@created_at}, #{@updated_at}"
  end

end

mg = MerchantGenerator.new
puts "id,name,created_at,updated_at"
40.times do MerchantGenerator.new
  @counter += 1
  mg.id_setter
  mg.name_setter
  mg.created_at_setter
  mg.updated_at_setter
  mg.output
end
