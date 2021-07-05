Dir.chdir '/Users/josh/code/jsl/black_thursday/'

require 'csv'
require 'json'

module EtsyHelpers
  attr_reader :result
  def format_time(seconds_i_think)
    Time.at(seconds_i_think).utc
  end
  def get(key, default=:raise)
    raise "NO KEY GIVEN!" unless key
    key   = key.to_s
    value = @result[key]
    return value   if value
    return default unless default == :raise
    raise "NO KEY #{key.inspect} IN #{@result.keys.inspect}"
  end

  def created_at
    seconds = get(:creation_tsz, random_seconds)
    format_time seconds
  end
  def updated_at
    seconds = get(:last_updated_tsz, random_seconds)
    format_time seconds
  end
  private
  def random_seconds
    rand 1452543954
  end
end

class Shop
  include EtsyHelpers
  attr_reader :listings

  def initialize(result, listings)
    @result   = result
    @listings = listings
  end

  def id
    get :shop_id
  end

  def name
    get :shop_name
  end
end


class Listing
  include EtsyHelpers
  def initialize(result)
    @result = result
  end

  def id
    get :listing_id
  end

  def shop_id
    get :shop_id
  end

  def shop_name
    get :shop_name
  end

  def name
    get :title
  end

  def unit_price
    dollars, pennies = get(:price).split(".")
    dollars.to_i * 100 + pennies.to_i
  end

  def description
    get :description
  end
end



listings_by_shop_id = Dir['tmp/listing*']
  .map { |filename| Listing.new JSON.parse File.read filename }
  .group_by { |listing| listing.shop_id }

shops = Dir['tmp/shop*'].map do |filename|
  result   = JSON.parse File.read filename
  listings = listings_by_shop_id.fetch(result["shop_id"], [])
  listings.uniq!(&:name)
  Shop.new result, listings
end

shops.reject! { |s| s.listings.empty? }

# merchants.csv | 100
#   id,name,created_at,updated_at
#   1,Schroeder-Jerde,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
# items.csv | 2500
#   id,name,description,unit_price,merchant_id,created_at,updated_at
#   1,Item Qui Esse,Nihil autem sit odio inventore deleniti.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 1

File.open "data/merchants.csv", "wb" do |file|
  CSV file do |csv|
    csv << %w[id name created_at updated_at]
    shops.each do |shop|
      csv << [shop.id, shop.name, shop.created_at, shop.updated_at]
    end
  end
end

File.open "data/items.csv", "wb" do |file|
  CSV file do |csv|
    csv << %w[id name description unit_price merchant_id created_at updated_at]
    shops.flat_map(&:listings).sort_by(&:id).each do |listing|
      csv << [listing.id, listing.name, listing.description, listing.unit_price, listing.shop_id, listing.created_at, listing.updated_at]
    end
  end
end
