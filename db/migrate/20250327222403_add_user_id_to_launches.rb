class AddUserIdToLaunches < ActiveRecord::Migration[8.0]
  def change
    add_reference :lti_provider_launches, :lti_provider_user, foreign_key: { to_table: :lti_provider_users }, type: :uuid
  end
end
