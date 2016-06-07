module Puppet::Parser::Functions
  newfunction(
    :eyaml_string,
    :type  => :rvalue,
    :arity => -2,
  ) do |args|

    require 'puppet/util/eyaml_functions'
    lookup = Puppet::Util::Eyaml_functions.new(args[0], args[1])
    lookup.do_decrypt

  end
end
