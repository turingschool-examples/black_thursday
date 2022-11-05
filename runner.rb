require 'benchmark'

time = Benchmark.measure {
  eval File.read('../black_thursday_spec_harness/spec/iteration_0_spec.rb')
  eval File.read('../black_thursday_spec_harness/spec/iteration_1_spec.rb')
  eval File.read('../black_thursday_spec_harness/spec/iteration_2_spec.rb')
  eval File.read('../black_thursday_spec_harness/spec/iteration_3_spec.rb')
}
puts time.real