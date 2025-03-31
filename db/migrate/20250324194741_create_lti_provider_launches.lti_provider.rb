# This migration comes from lti_provider (originally 20130319050003)
class CreateLtiProviderLaunches < ActiveRecord::Migration[4.2]
  def change
    # TODO: uuid
    create_table :lti_provider_launches, force: true do |t|
      t.string   :canvas_url
      t.string   :nonce
      t.jsonb    :provider_params

      # TODO: can we just use the nonce?
      # call it grade_runner_submission_token?
      t.string   :submission_token

      # TODO: add reference to resources
      t.references :resource

      t.timestamps
    end
  end
end
