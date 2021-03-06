require 'cgi'
require 'curl'
require 'date'

class Reminder

  def Reminder.need_remind_now?(day, hour)
    day_now = DateTime.now.strftime('%u').to_i
    right_day = day.to_i + 1 == day_now

    right_day && Reminder.right_hour(hour)
  end

  def Reminder.remind(token, user_id, text)
    CURL.new.get("https://api.telegram.org/bot#{token}/sendMessage?chat_id=#{user_id}&text=#{CGI.escape(text)}")
  end

  private

  def Reminder.right_hour(hour)
    hour_now = DateTime.now.strftime('%H').to_i + 3 #Надеюсь никто этого не увидит
    minute_now = DateTime.now.strftime('%M').to_i

    hour == hour_now || (hour - 1 == hour_now && minute_now > 55)
  end

end
