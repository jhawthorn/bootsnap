
ENV['BOOTSNAP_CACHE_DIR'] = 'tmp/'

def get_value_for(n, env: '')
  `#{env} ruby test.rb #{n}`.strip
end

def checkout(ref)
  system "git checkout #{ref}"
end

puts "no_bootsnap\tcurrent\tno_nested_retry\tonly_top_level_retry"
10.times do |n|
  checkout("activesupport_retrying")
  print get_value_for(n, env: "NO_BOOTSNAP=1")

  print "\t"

  checkout("activesupport_retrying~~")
  print get_value_for(n)

  print "\t"

  checkout("activesupport_retrying~")
  print get_value_for(n)

  print "\t"

  checkout("activesupport_retrying")
  print get_value_for(n)
  puts
end
