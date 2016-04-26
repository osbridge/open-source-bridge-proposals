OpenSourceBridgeProposals::Application.configure do
  secrets_file = Rails.root.join('config', 'secrets.yml')
  unless File.exists?(secrets_file)
    raise "Oops, config/secrets.yml could not be found."
  end

  secrets = YAML.load_file(secrets_file)
  config.action_mailer.delivery_method = secrets["email"]["delivery_method"]
  config.action_mailer.smtp_settings = secrets["email"]["smtp_settings"]
  # override email setting
  config.email = {
    "action_mailer" => {"enabled" => true},
    "default_from_address" => "content@opensourcebridge.org"
  }

  # OpenConferenceWare::SpeakerMailer looks for settings under OpenConferenceWare.email
  OpenConferenceWare.email = config.email

end
