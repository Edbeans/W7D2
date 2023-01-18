class Like < ApplicationRecord
    validates :liker_id, uniqueness: {scope: :chirp_id}

    belongs_to :liker,
        primary_key: :id,
        foreign_key: :liker_id,
        class_name: :User

    belongs_to :chirp,
        primary_key: :id,
        foreign_key: :chirp_id,
        class_name: :Chirp
end
