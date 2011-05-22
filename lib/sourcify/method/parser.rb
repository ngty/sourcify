%w{raw_scanner}.each do |file|
  Sourcify.require_rb('method', 'parser', file)
end
