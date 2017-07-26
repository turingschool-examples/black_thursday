require 'csv'

class ItemRepository
  def initialize(file_path, sales_engine)
    @file_path = file_path
    @sales_engine = sales_engine
    @id_repo = {}
    @name_repo = {}
    @description_repo = {}
    @price_repo = {}
    @merchant_id_repo = {}
  end

  def load_to(repo, )

  def load_repo
    itemcsv = CSV.open file_path, headers: true, header_converters: :symbol
    itemcsv.each do |row|
      item_hash = {id:, name:,}
