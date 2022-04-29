require 'rails_helper'

RSpec.describe User, type: :model do
  describe '新規ユーザー登録' do
    context 'name・email・passwordが正確に入力されている' do
      it 'アカウントが作成される' do
        user = FactoryBot.build(:user)
        expect(user).to be_valid
      end
    end

    context 'nameが空の場合' do
      it 'バリデーション（name空制約）により登録ができない' do
        user = FactoryBot.build(:user, name: nil)
        expect(user).not_to be_valid
      end
    end

    context 'nameが256文字以上の場合' do
      it 'バリデーション（256文字以上制限）により登録ができない' do
        user = FactoryBot.build(:user, name: 'a' * 256)
        expect(user).not_to be_valid
      end
    end

    context 'emailが空の場合の場合' do
      it 'バリデーション（email空制約）により登録ができない' do
        user = FactoryBot.build(:user, email: nil)
        expect(user).not_to be_valid
      end
    end

    context 'emailの形式が異なる場合' do
      it 'バリデーション（email形式制約）により登録ができない' do
        user = FactoryBot.build(:user, email: 'aaa')
        expect(user).not_to be_valid
      end
    end
    
    context 'passwordが空の場合' do
      it 'バリデーション（password空制約）により登録ができない' do
        user = FactoryBot.build(:user, password: nil)
        expect(user).not_to be_valid
      end
    end

    context 'passwordが6文字未満の場合' do
      it 'バリデーション（password形式制限）により登録ができない' do
        user = FactoryBot.build(:user, password: '11111')
        expect(user).not_to be_valid
      end
    end
  end
end
