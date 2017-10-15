class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_coupon.subject
  #
  def sendmail_coupon(coupon, targetSendEmail)
    #@greeting = "Hi"
    @coupon = coupon
    @targetSendEmail = targetSendEmail

    mail to: @targetSendEmail,
      #メールのタイトルを設定する
      subject: '【お知らせ】お店からクーポンが発行されました。'
  end
end
