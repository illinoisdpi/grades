module LtiProvider
  class Launch < ApplicationRecord
    include Buildable, Resourceable, Roleable, Tokenable, Userable, XmlConfigurable
  end
end
