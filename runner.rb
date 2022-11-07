require 'benchmark'

time = Benchmark.measure {
  Dir.chdir('../black_thursday_spec_harness'){
    system('bundle exec rake spec')
  }
}
puts time.real