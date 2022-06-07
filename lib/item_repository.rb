require 'pry'
require 'csv'
require_relative '../lib/item'
require './repositable'

class ItemRepository
  include Repositable
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []

      if @file_path
        CSV.foreach(@file_path, headers: true, header_converters: :symbol) do |row|
          @all << Item.new({
            :id => row[:id],
            :name => row[:name],
            :description => row[:description],
            :unit_price => row[:unit_price],
            :created_at => row[:created_at],
            :updated_at => row[:updated_at],
            :merchant_id => row[:merchant_id]})
        end
      end
    end


    # def find_by_id(id)
    #     @all.find do |item|
    #         if item.id == id
    #             return item
    #         end
    #     end
    # end

    # def find_by_name(name)
    #     @all.find do |item|
    #         if item.name.downcase == name.downcase
    #             return item
    #         end
    #     end
    # end

    def find_all_with_description(description)
      @all.find_all do |item|
        item.description.downcase.include?(description.downcase)
      end
    end

    def find_all_by_price(price)
      @all.find_all do |item|
        item.unit_price == price
      end
    end

    def find_all_by_price_in_range(range)
      @all.find_all do |item|
        item.unit_price.between?(range.first, range.last)
      end
    end

    def find_all_by_merchant_id(merchant_id)
      @all.find_all do |item|
        item.merchant_id == merchant_id
      end
    end

    def create(attributes)
        new_id = attributes[:id] = @all.last.id + 1
        @all << Item.new(:id => new_id, :name => attributes[:name],:description => attributes[:description],
        :unit_price => attributes[:unit_price], :created_at => attributes[:created_at],
        :updated_at => attributes[:updated_at], :merchant_id => attributes[:merchant_id])
    end

    def update(id,attributes)
        item = find_by_id(id)
        item.name = attributes[:name] if attributes[:name] != nil
        item.description = attributes[:description] if attributes[:description] != nil
        item.unit_price = attributes[:unit_price] if attributes[:unit_price] != nil
    end

    # def delete(id)
    #     item = find_by_id(id)
    #     @all.delete(item)
    # end


end
