module GroupingsHelper
  def group_admin? # ログイン中のユーザーがグループ管理者か判別を行なっている
    @groupings.each do |grouping|
      return true if grouping.admin == true && current_user == grouping.user
    end
    false
  end
end