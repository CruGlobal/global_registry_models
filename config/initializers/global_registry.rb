
GlobalRegistry.access_token = Rails.application.secrets[:global_registry_access_token]
raise 'No Global Registry access token specified!' unless GlobalRegistry.access_token.present?

GlobalRegistry.base_url = Rails.env.production? ? 'https://api.global-registry.org/' : 'https://stage-api.global-registry.org/'
