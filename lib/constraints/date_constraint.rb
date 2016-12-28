class DatesConstraint
  def matches?(request)
    year, month, day = request.params.values_at(:year_id, :month_id, :day_id)
    day =~ /\A\d{1,2}\z/ && Date.valid_date?(*[year, month, day].map(&:to_i))
  end
end