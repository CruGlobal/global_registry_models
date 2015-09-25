GlobalRegistry.access_token = ENV['GLOBAL_REGISTRY_ACCESS_TOKEN']
raise 'No Global Registry access token specified!' unless GlobalRegistry.access_token.present?

GlobalRegistry.base_url = Rails.env.production? ? 'https://api.global-registry.org/' : 'https://stage-api.global-registry.org/'
