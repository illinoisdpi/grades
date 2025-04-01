class CreateLtiProviderUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :lti_provider_users, id: :uuid do |t|
      t.text   :tool_consumer_instance_name
      t.text   :lis_person_name_given
      t.text   :lis_person_name_family
      t.text   :lis_person_name_full
      t.text   :lis_user_id

      t.timestamps
    end
    add_index :lti_provider_users, :lis_user_id
  end
end
