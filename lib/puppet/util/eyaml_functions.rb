module Puppet::Util
  class Eyaml_functions
    require 'yaml'

    begin
      require 'trollop'
      require 'hiera/backend/eyaml/subcommands/decrypt'
      Trollop::options
    rescue LoadError => e
      raise 'The hiera-eyaml gem is not installed'
    end

    def initialize(
      lookup,
      type = :string
    )
      @lookup = lookup
      @type   = type.to_sym

      # Use separate eyaml config if exists, or else hiera.yaml
      non_hiera_config = "#{Puppet.settings[:environmentpath]}/#{Puppet.settings[:environment]}/eyaml.yaml"
      hiera_config     = Puppet.settings[:hiera_config]
      config_file      = File.exists?(non_hiera_config) ? non_hiera_config : hiera_config
      @config          = load_config(config_file)
    end

    def do_decrypt
      Hiera::Backend::Eyaml::Options[:input_data] =
        Hiera::Backend::Eyaml::Subcommands::Decrypt.validate(setup_options)[:input_data]
      Hiera::Backend::Eyaml::Options['pkcs7_public_key']  = @config[:pkcs7_public_key]
      Hiera::Backend::Eyaml::Options['pkcs7_private_key'] = @config[:pkcs7_private_key]
      Hiera::Backend::Eyaml::Subcommands::Decrypt.execute
    end

    private

    def load_config(file)
      begin
        config = YAML::load_file(file)
      rescue Exception => e
        raise "Unable to load #{file}"
      else
        config[:eyaml]
      end
    end

    def setup_options
      { @type => @lookup, }
    end

  end
end
