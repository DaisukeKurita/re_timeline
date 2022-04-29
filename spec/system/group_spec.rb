require 'rails_helper'

RSpec.describe Group, type: :system do
  describe 'グループ機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user2) }
    let!(:group2) { FactoryBot.create(:group2)}

    before do
      visit root_path
      find("body header").click_link 'ログイン'
      fill_in 'Eメール', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      click_on 'グループ新規登録', match: :first
      fill_in 'グループ名', with: 'komugi'
      fill_in 'グループ説明', with: 'cat'
      click_button '登録する'
      find("body header").click_link '所属グループ一覧'
    end

    describe 'グループ登録機能' do
      context 'グループを新規登録した場合' do
        it 'グループが登録される' do
          click_on 'グループ新規登録', match: :first
          fill_in 'グループ名', with: 'group1'
          fill_in 'グループ説明', with: 'aaaaa'
          click_button '登録する'
          expect(page).to have_content 'group1'
        end
      end

      context '所属していないグループ詳細画面に飛ぼうとした場合' do
        it '所属グループ一覧画面に遷移する' do
          visit group_path(group2)
          expect(page).to have_content '所属グループ一覧'
        end
      end
    end

    describe 'グループ情報詳細' do
      context 'グループ詳細画面リンクをクリック' do
        it 'グループ詳細画面に遷移する' do
          click_on 'グループ情報詳細', match: :first
          expect(page).to have_content 'komugi'
        end
      end
    end

    describe 'グループ情報編集・更新' do
      context 'グループ情報編集・更新をする' do
        it 'グループ情報が更新される' do
          click_on 'グループ情報編集', match: :first
          fill_in 'グループ名', with: 'oomugi'
          click_button '更新する'
          expect(page).to have_content 'oomugi'
        end
      end
    end

    describe 'グループ削除' do
      context 'グループを削除する' do
        it 'グループが削除される' do
          expect{
            click_on 'グループ削除', match: :first
            page.accept_confirm "本当に削除しますか？"
            sleep 0.5
          }.to change{Group.count}.by(-1)
        end
      end
    end
  end
end