class CreateResources < ActiveRecord::Migration[8.0]
  def change
    create_table :resources do |t|
      t.string :context_id, null: false
      t.string :resource_link_id, null: false
      t.string :project_url

      t.timestamps
    end

    add_index :resources, [ :context_id, :resource_link_id ], unique: true
  end
end
