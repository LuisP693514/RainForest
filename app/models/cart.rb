# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  session    :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord

    before_validation :ensure_session
    validates :session, presence: true, uniqueness: true

    belongs_to :user,
        foreign_key: :user_id,
        class_name: :User,
        optional: true

    has_many :cart_items,
        foreign_key: :cart_id,
        class_name: :CartItem,
        dependent: :destroy

    private

    def ensure_session
        self.session ||= SecureRandom::urlsafe_base64
    end
end
