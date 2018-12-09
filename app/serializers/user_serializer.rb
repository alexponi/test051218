# frozen_string_literal: true

# User serializer to hide private and unnecessary data
class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :email, :name
end
