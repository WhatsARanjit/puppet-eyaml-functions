module Puppet::Util
  class Eyaml_functions
    require 'yaml'

    begin
      require 'trollop'
      require 'hiera/backend/eyaml/subcommands/decrypt'
      Trollop::options
    rescue LoadError => e
      raise Puppet::ParseError, 'The hiera-eyaml gem is not installed'
    end

    def initialize(
      lookup,
      group = false
    )
      @lookup = lookup
      @group  = group

      # Use separate eyaml config if exists, or else hiera.yaml
      non_hiera_config = "#{Puppet.settings[:environmentpath]}/#{Puppet.settings[:environment]}/eyaml.yaml"
      hiera_config     = Puppet.settings[:hiera_config]
      config_file      = File.exists?(non_hiera_config) ? non_hiera_config : hiera_config
      @config          = load_config(config_file)
    end

    def get_public_key
      begin
        ret = @config[@group][:pkcs7_public_key]
      rescue NoMethodError => e
       ret = @config[:pkcs7_public_key]
      end
      ret
    end

    def get_private_key
      begin
        ret = @config[@group][:pkcs7_private_key]
      rescue NoMethodError => e
       ret = @config[:pkcs7_private_key]
      end
      ret
    end

    def do_decrypt
      Hiera::Backend::Eyaml::Options[:input_data] =
        Hiera::Backend::Eyaml::Subcommands::Decrypt.validate(setup_options)[:input_data]
      Hiera::Backend::Eyaml::Options['pkcs7_public_key']  = get_public_key
      Hiera::Backend::Eyaml::Options['pkcs7_private_key'] = get_private_key
      Hiera::Backend::Eyaml::Subcommands::Decrypt.execute
    end

    private

    def load_config(file)
      begin
        config = YAML::load_file(file)
      rescue Exception => e
        raise Puppet::ParseError, "Unable to load #{file}"
      else
        config[:eyaml]
      end
    end

    def setup_options
      { :string => @lookup, }
    end

  end
end
