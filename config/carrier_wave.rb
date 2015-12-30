if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      # Configuration for Amazon S3
      :provider              => 'AWS',
      :aws_access_key_id     => ENV['AKIAJAVHCVYWRFBYB2EA'],
      :aws_secret_access_key => ENV['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']
    }
    config.fog_directory     =  ENV['bucket.s3.amazonaws.com']
  end
end