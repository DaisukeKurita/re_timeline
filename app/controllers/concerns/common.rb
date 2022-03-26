module Common
  extend ActiveSupport::Concern

  def set_group_id
    @group = Group.find(params[:group_id])
  end

   # 所属していないグループ情報にアクセスすると、グループ一覧にリダイレクトされる
  def current_user_belong_to_groups?
    redirect_to groups_path unless current_user.groups.ids.include?(@group.id.to_i)
  end

  # ログイン中のユーザーがグループ管理者か判別を行なっている
  # groupings_helperから移動してきたメソッド
  def group_admin?
    Grouping.find_by(user_id: current_user.id, group_id: @group.id).admin
  end

  # group_admin?をviewで扱いやすいよう変数に代入
  # helperにgroup_admin?を書いて、viewにgroup_admin?を直書きするとeach文の時にその都度
  # groupingsテーブルにアクセスする事が発覚した為、このようにしている。
  def group_admin_or_general
    @group_admin_or_general = group_admin?
  end
end