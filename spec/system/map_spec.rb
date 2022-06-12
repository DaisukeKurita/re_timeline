require 'rails_helper'

RSpec.describe Map, type: :system do
  describe 'マップ機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:group) { FactoryBot.create(:group) }

    before do
      FactoryBot.build(:grouping, user: user, group: group)
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
      click_link 'グループ日記一覧'
      find('#diary_new_link').click
      sleep 1
      fill_in 'タイトル', with: 'aaaaaa'
      fill_in 'イベント年月日', with: '002017/07/12'
      fill_in '内容', with: 'bbbbbb'
      attach_file '写真', "#{Rails.root}/spec/fixtures/test.jpeg"
      fill_in 'イベント時間', with: '12:00'
      fill_in 'address', with: '富士山'
      click_button '地図検索'
      sleep 0.5
      click_button '確認'
      click_button '投稿する'
    end

    describe 'マップ登録機能' do
      context 'マップ情報を新規登録した場合' do
        it 'マップ情報が登録される' do
          sleep 0.5
          expect(Map.count).to eq 1
        end
      end

      context '所属していないグループの地図情報に飛ぼうとした場合' do
        it '所属グループ一覧画面に遷移する' do
          visit group_maps_path(group)
          expect(page).to have_content '所属グループ一覧'
        end
      end
    end

    describe 'マップ情報編集・更新機能' do
      context 'マップ情報を編集・更新した場合' do
        it 'マップ情報が登録される' do
          click_link '日記編集'
          fill_in 'address', with: '沼津駅'
          click_button '地図検索'
          sleep 0.5
          click_button '更新する'
          sleep 0.5
          expect(Map.where(address: '沼津駅').count).to eq 1
        end
      end
    end

    describe 'マップ情報削除機能' do
      context '日記を削除するとマップ情報が一緒に削除される' do
        it 'マップ情報が削除される' do
          expect{
            click_link '日記削除'
            page.accept_confirm '本当に削除しますか？'
            sleep 0.5
          }.to change{Map.count}.by(-1)
        end
      end
    end
  end
end