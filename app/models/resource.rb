class Resource < ApplicationRecord
  validates :context_id, presence: true
  validates :resource_link_id, presence: true

  # TODO: validate is a real URL
  validates :project_url, presence: true, allow_blank: true
end
