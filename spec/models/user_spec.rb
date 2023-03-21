require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end
  describe 'ユーザー新規登録' do
    context 'ユーザ登録ができる時' do
      it 'email、passwordとpassword_confirmation、nickname、last_name、first_name、how_last_name、how_first_name、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザ登録ができない時' do
      it 'メールアドレスが必須であること' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスが一意性であること' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'メールアドレスは、@を含む必要があること' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'パスワードが必須であること' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'パスワードは、半角英字のみだと保存できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは、半角英字のみだと保存できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'パスワードは、全角文字だと保存できない' do
        @user.password = 'あaa111'
        @user.password_confirmation = 'あaa111'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password には半角英字と数字の両方を含めて設定してください')
      end
      it 'ニックネームが必須であること' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it '苗字が必須であること' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it '名前が必須であること' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it '苗字は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.last_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name は漢字・ひらがな・カタカナで設定してください')
      end
      it '名前は、全角（漢字・ひらがな・カタカナ）での入力が必須であること。' do
        @user.first_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name は漢字・ひらがな・カタカナで設定してください')
      end
      it '苗字カナが必須であること' do
        @user.how_last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("How last name can't be blank")
      end
      it '名前カナが必須であること' do
        @user.how_first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("How first name can't be blank")
      end
      it '苗字カナは、カタカナでの入力が必須であること。' do
        @user.how_last_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('How last name はカタカナで設定してください')
      end
      it '名前は、カタカナでの入力が必須であること。' do
        @user.how_first_name = 'aaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('How first name はカタカナで設定してください')
      end
      it '生年月日が必須であること' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
