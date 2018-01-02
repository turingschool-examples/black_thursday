require_relative 'similar_attributes'

class ItemGenerator
  include SimilarAttributes

  attr_accessor :id, :name, :description,
              :unit_price, :merchant_id, :created_at,
              :updated_at

ITEM_DESCRIPTIONS = ["", "Its the friggen best thing ever you don't want to miss out on these puppies",
"Better than toast", "Heckin a! I love it!", "Freak out your friends and family with this thang", "Holy mommmmma thats crazy",
"We could do better but we didn't", "Bless you", "You da best please by my thing", "plz mattis!", "much design", "very word!", "i can haz consectetur.",
"much text.", "oh my full!", "want full.", "i iz cute?!", "many layout!", "go swag.", "want aenean", "so elit", "With a point as sharp as a razor this weapon will make sure your enemies are full of holes with deadly speed and precision",
"The blade itself is engraved.", "The cross-guard has an elegant owl head on each side", "grip wrapped in common, light brown boar hide.", "this weapon wasn't created by just any blacksmith",
"watch", "clock", "crossbow", "handlebar-moustache", "xylophone made by xylophonists for xylophonists", "my little brony repellant", "a really awesome thing", "Adorned with tiny gold wings this vacuum cleaner enhances the user's memory",
"Any memories forgotten due to losing the item are regained when the item is put back into use.", "spice up your love life", "spicyyyy meatballlss", "best jambalaya the world has seen", "asdgfh", "gumba gumba", "clean up after yourself"]

NAMES = ["", "Tiny Toaster", "Large Toaster", "Medium Toaster", "Sick red boots", "Stupid Shoes", "Dingers", "Blingers", "Poppers", "Stoppers", "Table-Thing", "Beatbox machine", "Goosebump Factory", "Banana Peelers", "coffee pot",
"strawberry slicer", "ninja", "ganglebuster", "whollup", "MARIAH CAREEYS GRATEST HITS", "Sick thing", "A HOly cow", "Pupper Scooper", "Painting", "Drawling", "Thing", "better thing", "best rthing", "SUPER SOUPER", "Ramen Machine",
"Dungeon Master Disaster", "bubblegum", "startwarts 99", "Jims Best Thing", "Camerons Best Thing", "Stupid thing", "An ITem", "An Item 2", "An Item 3", "Bold sthuff", "Guitar"]

UNIT_PRICE = [2200, 11999, 7000, 900, 845, 4455, 99222, 585223, 22111, 4422, 5555, 9999, 6666, 22222, 33311, 94454]


  def initialize
    @id = 0
    @name = name
    @description = description
    @unit_price = unit_price
    @merchant_id = merchant_id
    @created_at = created_at
    @updated_at = updated_at
  end

  def id_setter
    @id += 1
  end

  def name_setter
    @name = NAMES[id]
  end

  def description_setter
    @description = ITEM_DESCRIPTIONS[id]
  end

  def unit_price_setter
    @unit_price = UNIT_PRICE.sample(1).join.to_i
  end

  def merchant_id_setter
    @merchant_id = merchant_ids.sample(1).join.to_i
  end

  def created_at_setter
    @created_at = created_at_updated_at.sample(1).join
  end

  def updated_at_setter
    @updated_at = created_at_updated_at.sample(1).join
  end

  def output
    puts "#{@id}, #{@name}, #{@description}, #{@unit_price}, #{@merchant_id}, #{@created_at}, #{@updated_at} "
  end

end
ig = ItemGenerator.new
puts "id,name,description,unit_price,merchant_id,created_at,updated_at"
40.times do ItemGenerator.new
  ig.id_setter
  ig.name_setter
  ig.description_setter
  ig.unit_price_setter
  ig.merchant_id_setter
  ig.created_at_setter
  ig.updated_at_setter
  ig.output
end
