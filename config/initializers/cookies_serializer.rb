# Applications created before Rails 4.1 uses Marshal to serialize cookie values 
# into the signed and encrypted cookie jars.
Rails.application.config.action_dispatch.cookies_serializer = :hybrid