require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

      it "全ての項目の入力が存在すれば登録できること" do
        expect(@user).to be_valid
      end

      it "nicknameがない場合は登録できないこと" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it "passwordがない場合は登録できないこと" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it "passwordが数字のみの場合は登録できないこと" do
        @user.password = "1234567"
        @user.valid?
        expect(@user.errors[:password]).to include("is invalid")
      end

      it "passwordが英文字のみの場合は登録できないこと" do
        @user.password = "abcdefg"
        @user.valid?
        expect(@user.errors[:password]).to include("is invalid")
      end

      it "emailがない場合は登録できないこと" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "encrypted_passwordがない場合は登録できないこと" do
        @user.encrypted_password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include()
      end

      it "family_nameがない場合は登録できないこと" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name can't be blank", "Family name is invalid")
      end

      it "family_name_kanaがない場合は登録できないこと" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana can't be blank", "Family name kana is invalid")
      end

      it "first_nameがない場合は登録できないこと" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name is invalid")
      end

      it "first_name_kanaがない場合は登録できないこと" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", "First name kana is invalid")
      end

      it "birth_strftimeがない場合は登録できないこと" do
        @user.birth_strftime = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth strftime can't be blank")
      end

      it "emailに@がない場合は登録できないこと " do
        @user.email = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it "重複したemailが存在する場合登録できない" do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end

      it "passwordが5文字以下であれば登録できない" do
        @user.password = "00000"
        @user.password_confirmation = "00000"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end

      it "passwordが存在してもpassword_confirmationが空では登録できない" do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'family_nameが全角入力でなければ登録できないこと' do
        @user.family_name = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name is invalid")
      end

      it 'first_nameが全角入力でなければ登録できないこと' do
        @user.first_name = "ｱｲｳｴｵ"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end

      it 'family_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.family_name_kana = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("Family name kana is invalid")
      end

      it 'first_name_kanaが全角カタカナでなければ登録できないこと' do
        @user.first_name_kana = "あいうえお"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
end