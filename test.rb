require 'active_support/dependencies'

unless ENV['NO_BOOTSNAP']
  require 'bootsnap/setup'
end

module ActiveSupport
  module Dependencies
    class << self
      mod = Module.new do
        def search_for_file(path)
          puts path if ENV['SEARCH_DEBUG']
          $total_searches += 1
          super
        end
      end
      prepend mod
    end
  end
end

# Define a deeply nested module, like
# ::Quux::Quuux::Quuuux::Quuuuux
defined_const = Object
N = (ARGV[0] || 5).to_i
N.times do |i|
  mod = Module.new
  defined_const.const_set("Q#{'u' * (i + 2)}x", mod)
  defined_const = mod
end

$total_searches = 0
begin
  defined_const.const_get("SomeClassIDontHave")
  "#{defined_const}::SomeClassIDontHave".constantize
rescue NameError
end
puts $total_searches
