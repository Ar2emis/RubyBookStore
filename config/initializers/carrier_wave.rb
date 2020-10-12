CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage    = :aws
    config.aws_bucket = Rails.application.credentials.aws[:bucket]
    config.aws_acl    = 'private'
    config.aws_credentials = {
      access_key_id:     Rails.application.credentials.aws[:access_key_id],
      secret_access_key: Rails.application.credentials.aws[:secret_access_key],
      region:            Rails.application.credentials.aws[:region],
    }
  elsif Rails.env.test?
    config.storage = :file
    config.enable_processing = false
  else
    config.storage = :file
  end
end