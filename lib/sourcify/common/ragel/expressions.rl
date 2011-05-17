%%{
  machine common_expressions;

  kw_class  = 'class';
  kw_module = 'module';
  kw_def    = 'def';
  kw_begin  = 'begin';
  kw_case   = 'case';
  kw_if     = 'if';
  kw_unless = 'unless';
  kw_do     = 'do';
  kw_then   = 'then';
  kw_for    = 'for';
  kw_while  = 'while';
  kw_until  = 'until';
  kw_end    = 'end';

  vchar   = alnum | '_';
  const   = upper . vchar* . ('::' . alpha . vchar*)*;
  var     = (lower | '_') . vchar*;
  meth    = (alpha | '_') . vchar*;
  symbol  = ':' . (var | const);
  assoc   = '=>';
  assgn   = '=';
  comma   = ',';
  label   = (var | const) . ':';

  lparen  = '(';
  rparen  = ')';
  lbrace  = '{';
  rbrace  = '}';
  smcolon = ';';
  newline = '\n';
  bslash  = '\\' . newline;
  ospaces = space* -- newline;
  mspaces = space+ -- newline;

}%%
