# frozen_string_literal: true

require_relative 'general'
require_relative 'calculable'
require_relative 'timeable'

# this is the GeneralRepo supeclass
class GeneralRepo
  include Calculable, Timeable
  attr_reader :repository,
              :engine

  def initialize(class_nm, data = {}, engine)
    @class_nm = class_nm
    @repository = []
    @engine = engine
    data.each { |general| create(general) }
  end

  def all
    @repository
  end

  def find_by_id(id)
    @repository.find { |general| general.id == id.to_i }
  end

  def create(general_data)
    general_data[:id] ||= (@repository.last.id.to_i + 1).to_s
    general = @class_nm.new(general_data, self)
    @repository << general
    general
  end

  def update(id, attribute_data)
    find_by_id(id)&.update(attribute_data)
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def send_up(message = {})
    @engine.send_down(message)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end
end
