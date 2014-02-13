# Loads Errbit config from YAML file

errbit_config_path = Rails.root.join("config", "errbit.yml")

if File.exists?(errbit_config_path)
  yaml_config = YAML.load_file(errbit_config_path)

  Airbrake.configure do |config|
    config.api_key = yaml_config['api_key']
    config.host    = yaml_config['host']
    config.port    = yaml_config['port'] || 80
    config.secure  = config.port == 443
  end
else
  puts "Could not find config/errbit.yml; skipping Errbit configuration."
end
