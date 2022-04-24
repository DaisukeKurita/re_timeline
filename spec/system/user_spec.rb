require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'ユーザー機能' do
    describe 'ユーザー新規登録' do
      context '一般ユーザーを新規登録した場合' do
        it '新規登録をした一般ユーザーが表示される' do
          visit root_path
          find("body header").click_link 'アカウント登録'
          fill_in 'ユーザー名', with: 'user1'
          fill_in 'Eメール', with: 'user1@gmail.com'
          fill_in 'パスワード', with: '111111'
          fill_in 'パスワード（確認用）', with: '111111'
          click_button '確認'
          click_button 'アカウント登録'
          expect(page).to have_content 'user1'
        end
      end

      context '一般ユーザーを登録しない場合' do
        it 'グループ一覧画面に飛ぼうとするとログイン画面に遷移する' do
          visit groups_path
          expect(page).to have_content 'ログイン'
        end
      end
    end

    describe 'ログイン機能' do
      let!(:user) { FactoryBot.create(:user) }
      let!(:user2) { FactoryBot.create(:user2) }
      
      before do
        visit root_path
        find("body header").click_link 'ログイン'
        fill_in 'Eメール', with: user.email
        fill_in 'パスワード', with: user.password
        click_button 'ログイン'
      end

      context '一般ユーザーがログインをする場合' do
        it 'グループ一覧画面に遷移する' do
          expect(page).to have_content '所属グループ一覧'
        end
      end

      context '一般ユーザーが他人の詳細画面に飛ぼうとする場合' do
        it '自分の詳細画面に遷移する' do
          visit user_path(user2)
          expect(page).to have_content 'user1'
        end
      end

      context '一般ユーザーがログアウトする場合' do
        it 'ログアウトする' do
          click_link 'ログアウト'
          expect(page).to have_content 'ゲストログイン（一般）'
        end
      end
    end

    describe '管理ユーザー機能' do
      let!(:admin_user) { FactoryBot.create(:admin_user)}
      let!(:user) { FactoryBot.create(:user) }

      before do
        visit root_path
        find("body header").click_link 'ログイン'
        fill_in 'Eメール', with: admin_user.email
        fill_in 'パスワード', with: admin_user.password
        click_button 'ログイン'
      end

      context '管理画面にアクセスをする場合' do
        it '管理ユーザーは管理画面にアクセスできる' do
          click_link '管理者画面'
          expect(page).to have_content 'サイト管理'
        end
      end
    end

    describe 'ゲストログイン機能' do
      before do
        visit root_path
      end

      context 'ゲストログイン（一般）リンクを押す' do
        it 'ゲストユーザー（一般）でログインできる' do
          click_link 'ゲストログイン（一般）'
          expect(page).to have_content '所属グループ一覧'
        end
      end

      context 'ゲストログイン（管理者）リンクを押す' do
        it 'ゲストユーザー（管理者）でログインできる' do
          click_link 'ゲストログイン（管理者）'
          click_link '管理者画面'
          expect(page).to have_content 'サイト管理'
        end
      end
    end
  end
end