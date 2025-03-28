class CreateLtiProviderUsers < ActiveRecord::Migration[8.0]
  def change
    # TODO: uuid
    create_table :lti_provider_users do |t|
      t.text :canvas_user_id
      t.text :lis_person_name_full
      t.text :lis_user_id
      t.text :lis_person_contact_email_primary
      t.text :user_image

      t.timestamps
    end
    add_index :lti_provider_users, :canvas_user_id
    add_index :lti_provider_users, :lis_user_id
  end
end
