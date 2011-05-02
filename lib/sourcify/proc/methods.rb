%w{source_location to_source to_sexp to_raw_source}.each do |file|
  Sourcify.require_rb('proc', 'methods', file)
end
