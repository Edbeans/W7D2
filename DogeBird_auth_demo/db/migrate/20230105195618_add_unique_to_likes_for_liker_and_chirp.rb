class AddUniqueToLikesForLikerAndChirp < ActiveRecord::Migration[7.0]
  def change
    add_index :likes, [:liker_id, :chirp_id], unique: true # liker_id should go first because it's easier to binary search through user
    # we have only 1 unique user, but a user can have many chirps 
  end
end
