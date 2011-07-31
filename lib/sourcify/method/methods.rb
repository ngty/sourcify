%w{to_source to_sexp to_raw_source}.each do |file|
  Sourcify.require_rb('method', 'methods', file)
end
