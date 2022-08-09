class HolidayFacade
  def self.upcoming
    read = HolidayService.holidays
    read[0..2].map do |data|
      Holiday.new(data)
    end
  end
end
