require 'dry-container'
require 'dry-auto_inject'
require 'cache'

module Markazuna
  class DiContainer
      extend Dry::Container::Mixin

      register :user_service do
          UserService.new
      end

      register :system_cache do
          Cache.instance # return singleton object
      end
  end
  # dependency injection
  INJECT = Dry::AutoInject(DiContainer)
end
