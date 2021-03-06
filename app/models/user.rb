# @userのメソッドがここで定義されている。
class User < ApplicationRecord
    has_many :microposts, dependent: :destroy
    attr_accessor :remember_token, :activation_token, :reset_token
    # self.email = self.email.downcaseと書いても良い
    before_save { self.email = email.downcase }
    before_save :downcase_email
    before_create :create_activation_digest
    # validatesにnameと`presence: true`という引数を与えている
    # validates(:name, presence: true, length:{ maximum: 50 })としても同じ
    validates :name, presence: true, length:{ maximum:50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length:{ maximum:255 }, 
        format: { with:VALID_EMAIL_REGEX}, 
        uniqueness: {case_sensitive: false} #重複は避け、大文字と小文字を区別しないという意味
    # レコードが追加された時だけに適用される
    has_secure_password
    validates :password, presence: true, length:{ minimum:6 }, allow_nil: true

    # 渡された文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続セッションのためにユーザーをデータベースに記憶する
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    # 渡されたトークンがダイジェストと一致したらtrueを返す
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    # ユーザーのログイン情報を破棄する
    def forget 
        update_attribute(:remember_digest, nil)
    end

    # アカウントを有効にする
    def activate
        update_attribute(:activated, true) # self.update_attributeともできるが今回のように省略もできる
        update_attribute(:activated_at, Time.zone.now)
    end
    # 有効化用のメールを送信する
    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    # パスワードの再設定の属性を設定する
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token)) # tokenをdigestに変換してデータベースの保存している
        update_attribute(:reset_sent_at, Time.zone.now)
    end

    # パスワードの再設定のメールを送信する
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end

    # パスワード再設定の期限が切れている場合はtrueを返す。
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end

    # フィード機能
    def feed
        Micropost.where("user_id=?", id)
    end

    private
    # メールアドレスを全て小文字にする
    def downcase_email
        self.email = email.downcase
    end
    # 有効化トークンとダイジェストを作成及び代入する
    def create_activation_digest
        self.activation_token = User.new_token # ランダムなトークンを返す
        self.activation_digest = User.digest(activation_token)
    end
end
