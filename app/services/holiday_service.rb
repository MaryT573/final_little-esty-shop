require 'httparty'

class HolidayService
  def holidays
    get_url("https://date.nager.at/swagger/index.html")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
