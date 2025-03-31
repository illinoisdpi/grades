class CreateLtiProviderLaunches < ActiveRecord::Migration[4.2]
  def change
    create_table :lti_provider_launches, id: :uuid, force: true do |t|
      t.string   :canvas_url
      t.string   :nonce
      t.text     :provider_params

      # TODO: can we just use the nonce?
      # call it grade_runner_submission_token?
      t.string   :submission_token
      t.references :resource, type: :uuid
      t.references :lti_provider_user, type: :uuid

      t.timestamps
    end
  end
end
