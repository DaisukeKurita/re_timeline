require 'rails_helper'

RSpec.describe Blog, type: :model do
  describe 'ブログ投稿機能' do
    context '正しく情報が入力されている' do
      it 'ブログが投稿される' do
        blog = FactoryBot.build(:blog)
        expect(blog).to be_valid
      end
    end

    context 'titieが空の場合' do
      it 'バリデーション（title空制約）により登録ができない' do
        blog = FactoryBot.build(:blog, title: nil)
        expect(blog).not_to be_valid
      end
    end

    context 'titieが256文字以上の場合' do
      it 'バリデーション（256文字以上制約）により登録ができない' do
        blog = FactoryBot.build(:blog, title: 'a' * 256)
        expect(blog).not_to be_valid
      end
    end
  end
end