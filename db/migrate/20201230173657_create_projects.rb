class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :desc
      t.string :vidlink
      t.string :gitlink

      t.timestamps
    end
  end
end
