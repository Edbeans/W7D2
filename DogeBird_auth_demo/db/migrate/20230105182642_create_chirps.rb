class CreateChirps < ActiveRecord::Migration[7.0]
  def change
    create_table :chirps do |t|
      t.text :body, null: false
      t.references :author, null: false, foreign_key: {to_table: :users} 
      # t.reference :author, null: false, foreign_key: {to_table: :users}, index: {unique: true} # creates a column author_id very specific 
      # t.references :user, foreign_key: true #user_id
      # t.integer :author_id, null: false 
      t.timestamps
    end
    # add_index :chirps, :author_id 
  end
end
