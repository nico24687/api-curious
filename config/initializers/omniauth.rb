Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :github, ENV['github_client_id'], ENV['github_client_secret'], scope: "read:org"
end