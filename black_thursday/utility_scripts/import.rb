require 'pry'
require 'etsy'
Etsy.protocol   = "https"
Etsy.api_key    = "rfbxa70abkze5b6u9jm1kh6k"
Etsy.api_secret = "oh27n3yw8u"
request         = Etsy.request_token
puts "Go here: #{Etsy.verification_url}"

code = 'get this code by visiting the verification url in the browser'
binding.pry

access = Etsy.access_token request.token, request.secret, code
me     = Etsy.myself(access.token, access.secret)

1.upto 20 do |i|
  Etsy::Shop.all(page: i).each do |shop|
    shop_path = "tmp/shop-#{shop.id}.json"
    File.write shop_path, shop.result.to_json
    shop.listings.each do |listing|
      listing_path = "tmp/listing-#{listing.id}.json"
      File.write listing_path, listing.result.merge("shop_id" => shop.id).to_json
    end
  end
end

require "pry"
binding.pry
