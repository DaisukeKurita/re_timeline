require 'rails_helper'

RSpec.describe Grouping, type: :system do
  describe 'Grouping機能' do

    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user2) }
    let!(:user3) { FactoryBot.create(:user3) }

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
      fill_in 'email', with: user2.email
      click_button '招待'
      expect(page).to have_content user2.email
    end

    describe 'Grouping新規登録' do
      context '新規グループを作成する' do
        it 'ログイン中のユーザーがグループ管理者としてメンバー登録される' do
          expect(page).to have_content user.email
          expect(page).to have_link '管理権限を解除'
        end
      end

      context '新規メンバーを増やす' do
        it '新規メンバーが増える' do
          fill_in 'email', with: user3.email
          click_button '招待'
          expect(page).to have_content user3.email
        end
      end
    end
    
    describe 'Grouping削除' do
      context 'メンバー削除をする' do
        it 'メンバーが削除される' do
          all('tbody tr')[2].click_link 'メンバー削除'
          page.accept_confirm '本当に削除しますか？'
          sleep 0.1
          expect(page).to have_content 'user2@gmail.comをメンバーから削除しました'
        end
      end

      context 'グループ管理者が1名の時に削除をする' do
        it 'グループ管理者は削除されない' do
          all('tbody tr')[1].click_link 'メンバー削除'
          page.accept_confirm '本当に削除しますか？'
          sleep 0.1
          expect(page).to have_content user.email
        end
      end

      context 'グループ管理者が2名の場合、1名のグループ管理者を削除をする' do
        it 'グループ管理者でも削除する事ができる' do
          all('tbody tr')[2].click_link '管理者権限を付与'
          page.accept_confirm '管理者権限を付与しますか？'
          sleep 0.1
          all('tbody tr')[1].click_link 'メンバー削除'
          page.accept_confirm '本当に削除しますか？'
          sleep 0.1
          expect(page).to have_content 'user1@gmail.comをメンバーから削除しました'
        end
      end
    end

    describe 'グループ管理権限' do
      context 'メンバーにグループ管理者権限を付与する' do
        it 'メンバーがグループ管理者になる' do
          all('tbody tr')[2].click_link '管理者権限を付与'
          page.accept_confirm '管理者権限を付与しますか？'
          sleep 0.1
          expect(Grouping.where(admin: true).count).to eq 2
          sleep 0.1
        end
      end

      context 'グループ管理者権限を解除する' do
        it 'グループ管理者がメンバーになる' do
          all('tbody tr')[2].click_link '管理者権限を付与'
          page.accept_confirm '管理者権限を付与しますか？'
          sleep 0.1
          all('tbody tr')[1].click_link '管理権限を解除'
          page.accept_confirm '管理権限を解除しますか？'
          sleep 0.1
          expect(Grouping.where(admin: true).count).to eq 1
          sleep 0.1
        end
      end
    end
  end
end