GlobalRegistry.access_token = Rails.application.secrets[:global_registry_access_token]
GlobalRegistry.base_url = ENV['GLOBAL_REGISTRY_API_URL']
