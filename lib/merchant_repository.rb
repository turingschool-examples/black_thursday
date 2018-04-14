# frozen_string_literal: true
require_relative 'merchant'
require_relative 'base_repository'

# merchant repo
class MerchantRepository < BaseRepository
  def merchants
    @models
  end

  def populate
    @models ||= csv_table_data.map { |attribute_hash| Merchant.new(attribute_hash, self)}
  end

  def find_all_by_name(name)
    found = merchants.map do |merchant|
      if merchant.name.downcase.include?(name.downcase)
        merchant
      end
    end
    found.compact
  end

  def find_highest_id
    merchants.map { |merchant| merchant.id }.max
  end

  def create_new_id
    find_highest_id + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now
    attributes[:updated_at] = Time.now
    merchants << Merchant.new(attributes, 'parent')
  end

  def update(id, attributes)
    return nil if find_by_id(id).nil?
    found = find_by_id(id)
    found.change_name(attributes[:name])
    found.change_updated_at
  end

  def pass_item_id_to_sales_engine(id)
    @parent.pass_item_id_to_item_repo(id)
  end
end
