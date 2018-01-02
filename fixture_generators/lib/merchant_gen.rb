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

end
