require 'Csv'

class SalesEngine


  def self.from_csv(file_path_hash)
    items_objs = CSV.read(file_path_hash[:items],
    headers: true, header_converters: :symbol)
    merchant_objs = CSV.read(file_path_hash[:merchants],
    headers: true, header_converters: :symbol)
    item_merchant_hash = {
      items: items_objs,
      merchants: merchant_objs
    }
    create_and_populate_item_repo
    create_and_populate_merchant_repo
    SalesEngine.new
  end

  def items
    @item_repo
  end

  def merchants
    @merchant_repo
  end

  private

  def self.create_and_populate_item_repo
    # TODO Are defineing the instance variables down here okay?
    @item_repo = ItemRepository.new
    items_objs.each do |item|
      item_repo.create(item)
    end
  end

  def self.create_and_populate_merchant_repo
    @merchant_repo = MerchantRepository.new
    merchant_objs.each do |item|
      item_repo.create(item)
    end
  end
end
