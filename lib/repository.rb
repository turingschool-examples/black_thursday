# frozen_string_literal: false

require_relative 'sales_engine'
# Responsible for holding all common methods for _repository classes
module Repository
  def all
    @repository
  end

  def find_by_id(id)
    @repository.find do |element|
      id == element.id
    end
  end

  def find_by_name(name)
    @repository.find do |element|
      name.downcase == element.name.downcase
    end
  end

  def find_all_by_name(name)
    @repository.find_all do |element|
      element.name.downcase.include?(name.downcase)
    end
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |element|
      id == element.merchant_id
    end
  end

  def find_all_by_invoice_id(id)
    @repository.find_all do |element|
      id == element.invoice_id
    end
  end

  def find_highest_id
    @repository.max_by(&:id)
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end
end
