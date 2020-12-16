class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
  validates :birth_strftime
  VALID_PASSWORD_REGEX = /\A[a-z0-9]+\z/i
  validates :password, length: { minimum: 6 },
                      format: { with: VALID_PASSWORD_REGEX }
  validates :nickname
  validates :first_name
  validates :family_name
  validates :first_name_kana
  validates :family_name_kana
  end 
  with_options format: {with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/} do
    validates :first_name
    validates :family_name
  end
  with_options format: {with: /\A[ァ-ヶー－]+\z/} do
    validates :first_name_kana
    validates :family_name_kana
  end
end