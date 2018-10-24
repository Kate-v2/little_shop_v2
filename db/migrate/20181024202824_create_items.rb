class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name
      t.string :image
      t.integer :price
      t.string :description
      t.boolean :active
      t.integer :inventory
      t.integer :user_id

      t.timestamps
    end
  end
end
