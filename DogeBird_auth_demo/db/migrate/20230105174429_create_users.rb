class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t| #the t represents the datatype for that column
      t.string :username, null: false #<- creates a string column username where the data must be NOT NULL hence null: false 
      t.string :email, null: false 
      t.timestamps
    end
    add_index :users, :username, unique: true # every unique constraint must be indexed 
    add_index :users, :email, unique: true # indexes help us find a specific data fast using a binary search method on a tree 
  end
end
