require 'rails_helper'

RSpec.describe Group, type: :model do
  describe 'グループ登録機能' do
    context 'name・explanationが正確に入力されている' do
      it 'グループが作成される' do
        group = FactoryBot.build(:group)
        expect(group).to be_valid
      end
    end

    context 'nameが空の場合' do
      it 'バリデーション（name空制約）により登録ができない' do
        group = FactoryBot.build(:group, name: nil)
        expect(group).not_to be_valid
      end
    end

    context 'nameが256文字以上の場合' do
      it 'バリデーション（256文字以上制約）により登録ができない' do
        group = FactoryBot.build(:group, name: 'a' * 256)
        expect(group).not_to be_valid
      end
    end

    context '同じグループ名で登録をしようとする場合' do
      it 'バリデーション（ユニーク制約）により登録ができない' do
        FactoryBot.create(:group3)
        group = FactoryBot.build(:group, name: 'group3')
        expect(group).not_to be_valid
      end
    end
  end
end
