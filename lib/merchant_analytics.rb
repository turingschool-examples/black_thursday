require 'bigdecimal'
require_relative 'standard_deviation'
require_relative 'sales_analyst'
require_relative 'sales_engine'
require 'erb'

class MerchantAnalytics < SalesAnalyst
  include StandardDeviation

  attr_reader :sales_engine, :analytics, :erb_template

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @erb_template = nil
    @analytics = {"Merchant" => {},
                  "All" => {},
                  "Top Earners" => {},
                  "Like Merchants: Revenue" => {},
                  "Like Merchants: Item Number" => {},
                  "Like Merchants: Item Price" => {}}
    #hardcoded to see if output correct, remove
    @analytics = {"Merchant" => {:name => "Merchant 1",
                  :revenue => 50, :items => 100,
                  :invoices => 30, :customers =>  10,
                  :average_price => 50},
                  "All" => {:revenue => 100, :items => 30,
                  :invoices => 100, :customers =>  15,
                  :average_price => 30},
                  "Top Earners" => {:revenue => 500, :items => 20,
                  :invoices => 50, :customers =>  10,
                  :average_price => 100},
                  "Like Merchants: Revenue" => {:revenue => 50, :items => 40,
                  :invoices => 90, :customers =>  40,
                  :average_price => 80},
                  "Like Merchants: Item Number" => {:revenue => 100, :items => 100,
                  :invoices => 90, :customers =>  40,
                  :average_price => 70},
                  "Like Merchants: Item Price" => {:revenue => 500, :items => 20,
                  :invoices => 50, :customers =>  40,
                  :average_price => 50}}
  end



  def setup_output_template #tested
    report_template = File.read "lib/index.html.erb"
    @erb_template = ERB.new report_template
  end

  def generate_report
    @erb_template.result(binding)
  end

  def save_report #test at end
    Dir.mkdir("public") unless Dir.exists? "public"
    filename = "public/index.html" #could put id in there

    File.open(filename,'w') do |file|
      file.puts generate_report
    end
  end

  def generate_merchant_hash(merchant) #hardcoded for now
    @analytics["Merchant"] = {:name => "Merch1", :revenue => 205, :items => 2, :invoices => 30, :customers =>  10, :average_price => 100}
  end

  def generate_all_hash
  end

  def generate_top_hash
  end

  def generate_like_rev_hash
  end

  def generate_like_item_num_hash
  end

  def generate_like_item_price_hash
  end

  def generate_like_subset(feature, range) #tested
    if feature == :revenue
      method = "revenue_by_merchant"
    elsif feature == :items
      method = "number_of_items"
    elsif feature == :average_price
      method = "average_item_price_for_merchant"
    end
    select_subset(feature, range, method)
  end

  def select_subset(feature, range, method) #tested
    sales_engine.merchants.all.select do |merchant|
      (self.send(method, merchant.id) <= (1 + range) * analytics["Merchant"][feature]) && (self.send(method, merchant.id) >= (1 - range) * analytics["Merchant"][feature])
    end
  end

  def number_of_items(merchant_id) #tested
    sales_engine.merchants.find_by_id(merchant_id).items.length
  end

  def revenue_by_merchant(merchant_id) #hardcoded until rev by merc built, then delete and udpate test
    200
  end

end


if __FILE__==$0
  se = SalesEngine.from_csv({
    :items     => "./data/small_items.csv",
    :merchants => "./data/small_merchants.csv"})
  ma = MerchantAnalytics.new(se)
  ma.setup_output_template
  ma.save_report
end
