module LtiProvider
  class Launch < ApplicationRecord
    include Initializeable, Resourceable, Roleable, Tokenable, Userable, XmlConfigurable
  end
end
