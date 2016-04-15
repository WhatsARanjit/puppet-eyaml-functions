module Puppet::Parser::Functions
  newfunction(
    :eyaml_file,
    :type  => :rvalue,
    :arity => 1,
  ) do |args|
    require 'trollop'
    require 'yaml'
    require 'hiera/backend/eyaml/subcommands/decrypt'
    Trollop::options
    config    = YAML::load_file(Puppet.settings[:hiera_config])
    options   = { :file => args[0], }

    Hiera::Backend::Eyaml::Options[:input_data] =
      Hiera::Backend::Eyaml::Subcommands::Decrypt.validate(options)[:input_data]
    Hiera::Backend::Eyaml::Options['pkcs7_public_key']  = config[:eyaml][:pkcs7_public_key]
    Hiera::Backend::Eyaml::Options['pkcs7_private_key'] = config[:eyaml][:pkcs7_private_key]
    Hiera::Backend::Eyaml::Subcommands::Decrypt.execute
  end
end
