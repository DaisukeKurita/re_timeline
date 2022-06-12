require 'rails_helper'

RSpec.describe diary, type: :model do
  describe '日記投稿機能' do
    context '正しく情報が入力されている' do
      it '日記が投稿される' do
        diary = FactoryBot.build(:diary)
        expect(diary).to be_valid
      end
    end

    context 'titieが空の場合' do
      it 'バリデーション（title空制約）により登録ができない' do
        diary = FactoryBot.build(:diary, title: nil)
        expect(diary).not_to be_valid
      end
    end

    context 'titieが256文字以上の場合' do
      it 'バリデーション（256文字以上制約）により登録ができない' do
        diary = FactoryBot.build(:diary, title: 'a' * 256)
        expect(diary).not_to be_valid
      end
    end
  end
end