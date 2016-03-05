## Black Thursday

Find the [project spec here](https://github.com/turingschool/curriculum/blob/master/source/projects/black_thursday.markdown).


## Horace's notes from 3/3/16

# ||=
# set this variable if it is not already defined as a truthy value

# all @-ivars are nil to start

class SalesEngine
  attr_reader :data, :merchants, :items, :sales_analyst

  def initialize(data={})
    # takes in data as a hash containing keys like :merchants, :items, :etc
    # generates and stores repos for each data type
    # {:merchants => [{:some => "merchant data"}]}
    @data = data

    # only create this if the csv_content for :merchants is provided
    @merchants = MerchantRepository.new(@data[:merchants], self)
    @items     = ItemRepository.new(@data[:items])
    # @transactions ||= TransactionRepository.new(....)
    # ...
    # ...
    # ...

    @sales_analyst ||= SalesAnalyst.new(self)
  end

  def self.from_csv(data)
    csv_content = {}
    data.each do |key, value|
      # "items", [item stuff....]
      csv_content[key] = CSV.read(value, headers: true, header_converters: :symbol)
    end
    SalesEngine.new(csv_content)
  end

end

###########################

class MerchantRepositoryTest < Minitest::Test
  #don't forget csv has created_at and updated_at
  def setup
    # merchants = [{:id => 1, :name => "pizza"}]
    # items     = [{:id => 1, :name => "pepperoni"}]
    #
    # SalesEngine.new({:merchants => merchants, :items => items})
     se = SalesEngine.from_csv({
                :merchants => './fixtures/merchants_fixtures.csv',
                :items     => './fixtures/items_fixtures.csv'
                })
     @mr = se.merchants

     #can we run this test with values?
     #@mr = MerchantRepository.new({id: "12334113", name: "MiniatureBikez"})
  end

  def test_all_returns_array_of_all_merchants
    @mr = MerchantRepository.new([{},{},{},{}], nil)
    # se = SalesEngine.new({:merchants => [{},{},{},{}], :items => []})
    # @mr = se.merchants

    # @mr = MerchantRepository.new([{:id => 1, :name => "lol", :what => ""}], nil)
    assert_equal Array, @mr.merchants.class
    assert_equal 4, @mr.all.count
  end

  def test_find_by_id_returns_merchant_object
    merchant = @mr.find_by_id(12334113)
    assert_equal "MiniatureBikez", merchant.name
    assert_equal Merchant, merchant.class
    assert_equal 12334113, merchant.id
  end

  def test_find_by_id_returns_nil_when_id_doesnt_exist
    assert_equal nil, @mr.find_by_id(123344342)
  end

  def test_find_by_name_finds_first_merchant
      merchant = @mr.find_by_name("MiniatureBikez")
      assert_equal 12334113, merchant.id
      assert_equal Merchant, merchant.class
      assert_equal "MiniatureBikez", merchant.name
  end

  def test_find_by_name_returns_nil_when_name_doesnt_exist
    assert_equal nil, @mr.find_by_name("lolz")
  end

  def test_find_by_name_is_case_insensitive
    merchant = @mr.find_by_name("CANDIsarT")
    assert_equal 12334112, merchant.id
  end

  def test_find_all_by_name_finds_all_merchants_with_name_fragment
    merchants = @mr.find_all_by_name("ture")

    assert_equal "MiniatureBikez", merchants[0].name
    assert_equal "NatureDots", merchants[1].name
  end

  def test_find_by_name_returns_empty_array_if_fragment_not_found
    merchants = @mr.find_all_by_name("hgfdse")

    assert_equal [], merchants
  end
end
