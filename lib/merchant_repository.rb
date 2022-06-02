class MerchantRepository
  attr_reader :file_path, :all


  def initialize(file_path)
    @file_path = file_path
    @all = []

    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Merchant.new(:id =>row[:id],:name => row[:name])
    end

  end

  def find_by_id(id)
    @all.find do |row|
      row.id == id

    end
  end

  def find_by_name(name)
    @all.find do |row|
      row.name.upcase == name.upcase
    end
  end

  def find_all_by_name(name)
    @all.find_all do |row|
      row.name.upcase.include?(name.upcase)
    end
  end

  def create(new_merchant_name)
    last_id = @all[-1].id
    new_id = last_id + 1
    @all <<  Merchant.new({:id => new_id,:name => new_merchant_name})
  end








end
