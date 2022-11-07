require_relative 'require_store'

class Repository
  include Find
  include Modify

  attr_accessor :all

  def initialize(filepath)
    @all = new_repository(filepath)
  end

  def add(attributes)
    thing = evaluate
    @all << thing.new(attributes)
  end

  def new_repository(filepath)
    thing = evaluate
    repository = []
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |attributes|
      repository << thing.new(attributes)
    end
    repository
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end