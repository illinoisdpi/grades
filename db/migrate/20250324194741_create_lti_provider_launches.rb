class CreateLtiProviderLaunches < ActiveRecord::Migration[4.2]
  def change
    create_table :lti_provider_launches, id: :uuid, force: true do |t|
      t.string   :canvas_url
      t.string   :nonce
      t.jsonb    :provider_params, null: false, default: '{}'
      t.string :submission_token # NOTE: used by grade_runner gem when submitting build
      t.references :resource, type: :uuid
      t.references :lti_provider_user, type: :uuid

      t.timestamps
    end
  end
end
