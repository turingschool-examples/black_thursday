# frozen_string_literal: true

require_relative 'general'

# this is the GeneralRepo supeclass
class GeneralRepo
  attr_reader :repository

  def initialize(class_nm, data = {}, se)
    @class_nm = class_nm
    @repository = []
    @se = se
    data.each { |general| create(general) }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |general| general.id == id.to_s }
  end

  def create(general_data)
    general_data[:id] ||= (@repository.last.id.to_i + 1).to_s
    general = Object.const_get(@class_nm).new(general_data, self)
    @repository << general
    general
  end

  def update(id, attribute_data)
    find_by_id(id).update(attribute_data)
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def inspect
    # "#<#{self.class} #{@merchants.size} rows>"
  end
end
