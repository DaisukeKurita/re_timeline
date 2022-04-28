require 'rails_helper'

RSpec.describe Blog, type: :system do
  describe 'ブログ機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:group) { FactoryBot.create(:group) }

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
      click_link 'グループブログ一覧'
      find("body header").click_link 'ブログ新規投稿'
      sleep 0.5
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

    describe 'ブログ投稿機能' do
      context 'ブログを新規投稿した場合' do
        it 'ブログが投稿される' do
          expect(page).to have_content 'aaaaaaが投稿されました'
        end
      end
      
      context '所属していないグループのブログに飛ぼうとした場合' do
        it '所属グループ一覧画面に遷移する' do
          visit group_blogs_path(group.id)
          expect(page).to have_content 'komugi'
        end
      end
    end

    describe 'ブログ詳細' do
      context 'ブログ詳細リンクをクリック' do
        it 'ブログ詳細ページに遷移する' do
          click_link 'ブログ詳細'
          expect(page).to have_content 'komugiブログ詳細'
        end
      end
    end

    describe 'ブログ編集・更新' do
      context 'ブログ情報編集・更新をする' do
        it 'ブログ情報が更新される' do
          click_link 'ブログ編集'
          fill_in 'タイトル', with: 'kkkkkk'
          click_button '更新する'
          expect(page).to have_content 'kkkkkkブログを編集しました'
        end
      end
    end

    describe 'ブログ削除' do
      context 'ブログを削除する' do
        it 'ブログが削除される' do
          expect{
            click_link 'ブログ削除'
            page.accept_confirm "本当に削除しますか？"
            sleep 0.5
          }.to change{Blog.count}.by(-1)
        end
      end
    end
  end
end