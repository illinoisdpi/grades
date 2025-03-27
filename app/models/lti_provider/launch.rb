module LtiProvider
  class Launch < ApplicationRecord
    include Buildable, Resourceable, Roleable, Tokenable, XmlConfigurable
  end
end
