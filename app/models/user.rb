class User < ApplicationRecord
    # self.email = self.email.downcaseと書いても良い
    before_save { self.email = email.downcase }
    # validatesにnameと`presence: true`という引数を与えている
    # validates(:name, presence: true, length:{ maximum: 50 })としても同じ
    validates :name, presence: true, length:{ maximum:50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length:{ maximum:255 }, 
        format: { with:VALID_EMAIL_REGEX}, 
        uniqueness: {case_sensitive: false} #重複は避け、大文字と小文字を区別しないという意味
    # レコードが追加された時だけに適用される
    has_secure_password
    validates :password, presence: true, length:{ minimum:6 }
end
