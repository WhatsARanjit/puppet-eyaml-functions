module Puppet::Parser::Functions
  newfunction(
    :eyaml_file,
    :type  => :rvalue,
    :arity => -2,
  ) do |args|

    require 'puppet/util/eyaml_functions'
    lookup = Puppet::Util::Eyaml_functions.new(function_file([args[0]]), args[1])
    lookup.do_decrypt

  end
end
