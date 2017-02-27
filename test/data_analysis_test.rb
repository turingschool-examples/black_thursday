require './test/test_helper'
require './lib/data_analysis'

class DataAnalysisTest < Minitest::Test

  def test_it_exists
    skip
    assert_instance_of DataAnalysis, DataAnalysis.whoami
  end
end
