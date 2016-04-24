require 'bigdecimal'
require_relative 'standard_deviation'
require_relative 'sales_analyst'
require_relative 'sales_engine'
require 'erb'

class MerchantAnalytics < SalesAnalyst
  include StandardDeviation

  attr_reader :sales_engine, :analytics

  def initialize(sales_engine)
    @sales_engine = sales_engine
    @erb_template = nil

    @analytics = {"Merchant" => {:revenue => 50, :items => 100,
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



  def setup_output_template
    report_template = File.read "lib/index.html.erb"
    @erb_template = ERB.new report_template
  end

  def generate_report
    @erb_template.result(binding)
  end

  def save_report
    Dir.mkdir("public") unless Dir.exists? "public"
    filename = "public/index.html" #could put id in there

    File.open(filename,'w') do |file|
      file.puts generate_report
    end
  end


end


if __FILE__==$0
  se = SalesEngine.from_csv({
    :items     => "./data/small_items.csv",
    :merchants => "./data/small_merchants.csv"})
  # se = SalesEngine.new
  ma = MerchantAnalytics.new(se)
  ma.setup_output_template
  ma.save_report
end
