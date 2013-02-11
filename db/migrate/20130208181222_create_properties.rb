class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :key
      t.string :value
      t.references :book

      t.timestamps
    end
    add_index :properties, :book_id
  end
end
