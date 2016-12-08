json.array!(@ngevents) do |event|
  json.partial! 'listing_ngevent', listing_ngevent: event
end
