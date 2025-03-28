class Resource < ApplicationRecord
  validates :context_id, presence: true
  validates :resource_link_id, presence: true

  # TODO: validate is a real URL
  validates :project_url, presence: true, allow_blank: true

  has_many :builds

  def project_path
    URI.parse(project_url).path[1..]
  end

  def to_s
    "Resource ##{id}: #{project_path}"
  end
end
