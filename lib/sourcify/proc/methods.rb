%w{source_location to_source to_sexp}.each do |file|
  Sourcify.require_rb('proc', 'methods', file)
end
