require './lib/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::test_helper

  def setup 
    @repo = ItemRepository.new([Item.new({
                                          :id => 263395237, 
                                          :name => "510+ RealPush Icon Set", 
                                          :description => HTMLEntities.new.decode("You&#39;ve got a total socialmedia iconset! Almost every social icon on the planet earth."), 
                                          :unit_price => BigDecimal.new(1200), 
                                          :merchant_id => 12334141, 
                                          :created_at => Time.utc(2016, 1, 11, 9, 34, 06), 
                                          :updated_at => Time.utc(2007, 6, 4, 21, 35, 10)
                                          })
                                Item.new({:id => 263395721, 
                                          :name => "Disney scrabble frames", 
                                          :description => HTMLEntities.new.decode("Disney glitter frames Any colour glitter available and can do any characters you require Different colour scrabble tiles Blue Black Pink Wooden"), 
                                          :unit_price => BigDecimal.new(1350), 
                                          :merchant_id => 12334185, 
                                          :created_at => Time.utc(2016, 01, 11, 11, 51, 37), 
                                          :updated_at => Time.utc(2008, 04, 02, 13, 48, 57)})
                                Item.new({:id => 263395721, 
                                          :name => "Free standing Woden letters", 
                                          :description => HTMLEntities.new.decode("Disney glitteFree standing wooden letters 15cm Any colours"), 
                                          :unit_price => BigDecimal.new(700), 
                                          :merchant_id => 12334185, 
                                          :created_at => Time.utc(2016, 0, 11, 11, 51, 36), 
                                          :updated_at => Time.utc(2001, 09, 17, 15, 28, 43)
                                          })
                                ])
  end


  def test_it

end

