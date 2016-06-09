module Formatter
  def self.parse(date)
    date.strftime("%B %e, %Y")
  end
end
