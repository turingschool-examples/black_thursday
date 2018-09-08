require 'Csv'

class SalesEngine

  attr_reader :items,
              :merchants

  def initialize
    @items = ItemRepository.new
    @merchants = MerchantRepository.new
  end


  def self.from_csv(file_path_hash)
    items_objs = CSV.read(file_path_hash[:items],
    headers: true, header_converters: :symbol)
    merchant_objs = CSV.read(file_path_hash[:merchants],
    headers: true, header_converters: :symbol)
    item_merchant_hash = {
      items: items_objs,
      merchants: merchant_objs
    }

    se = SalesEngine.new
    create_and_populate_item_repo(items_objs)
    create_and_populate_merchant_repo(merchant_objs)
    return se
  end

  private

  def self.create_and_populate_item_repo(items_objs)
    # TODO Are defineing the instance variables down here okay?
    # items_objs.each do |item|
    #   item_repo.create(item)
    # end
  end

  def self.create_and_populate_merchant_repo(merchant_objs)
    # merchant_objs.each do |item|
    #   item_repo.create(item)
    # end
  end
end
