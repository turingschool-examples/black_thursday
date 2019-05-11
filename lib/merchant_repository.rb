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
    merchants.select do |merchant|
      merchant.name.downcase.include?(name.downcase)
    end
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

  def pass_merchant_id_to_engine(id)
    @engine.pass_merchant_id_to_item_repo(id)
  end

  def pass_merchant_id_to_engine_for_invoice(id)
    @engine.pass_merchant_id_to_invoice_repo(id)
  end
end
