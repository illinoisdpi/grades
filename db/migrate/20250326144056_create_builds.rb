class CreateBuilds < ActiveRecord::Migration[8.0]
  def change
    create_table :builds, id: :uuid do |t|
      t.references :launch, null: false, foreign_key: { to_table: :lti_provider_launches }
      t.references :resource, null: false, foreign_key: true
      t.jsonb      :test_output
      t.text       :commit_sha
      t.citext     :username
      t.text       :reponame
      t.text       :source

      t.timestamps
    end
  end
end
