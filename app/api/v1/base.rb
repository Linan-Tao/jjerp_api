module V1
  class Base < RootAPI
    version 'v1', using: :path
    mount V1::Users
  end
end
