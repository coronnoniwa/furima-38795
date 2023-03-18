class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :how_last_name, presence: true
  validates :how_first_name, presence: true
  validates :birthday, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  JAPANESE_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  validates_format_of :first_name, :last_name, with: JAPANESE_REGEX, message: 'は漢字・ひらがな・カタカナで設定してください'

  KATAKANA_REGEX = /\A[ァ-ヶ一]+\z/
  validates_format_of :how_first_name, :how_last_name, with: KATAKANA_REGEX, message: 'はカタカナで設定してください'
end
