class UserMailer < ApplicationMailer

  def confirm(user)
    @user = user
    mail(to: @user.email, subject: 'メールアドレス認証')
  end

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: 'パスワード再設定')
  end

  def password_reset_complete(user)
    @user = user
    mail(to: @user.email, subject: 'パスワード再設定完了')
  end



end
