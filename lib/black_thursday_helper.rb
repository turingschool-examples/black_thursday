require 'CSV'
require 'pry'
module BlackThursdayHelper

  def all
    @collections
  end

  def find_by_id(id)
   @collections.find do |object|
     object.id == id
   end
  end

  def find_by_name(name)
    @collections.find do |object|
      object.name == name
    end
  end

  def find_all_by_name(name)
   @collections.find_all do |object|
     object.name.downcase.include? (name.downcase)
   end
  end



  # def populate(filepath)
  #   CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
  #     @merchants << Merchant.new(data)
  #   end
  # end

end
