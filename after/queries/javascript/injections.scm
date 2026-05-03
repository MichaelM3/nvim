; extends

((variable_declarator
  (comment) @_sql_comment
  value: (template_string
   (string_fragment) @injection.content))
 (#match? @_sql_comment "^/\\*\\s*sql\\s*\\*/$")
 (#set! injection.language "sql"))

((arrow_function
  (comment) @_sql_comment
  body: (template_string
   (string_fragment) @injection.content))
 (#match? @_sql_comment "^/\\*\\s*sql\\s*\\*/$")
 (#set! injection.language "sql"))

((return_statement
  (comment) @_sql_comment
  (template_string
   (string_fragment) @injection.content))
 (#match? @_sql_comment "^/\\*\\s*sql\\s*\\*/$")
 (#set! injection.language "sql"))

((ternary_expression
  (comment) @_sql_comment
  consequence: (template_string
   (string_fragment) @injection.content))
 (#match? @_sql_comment "^/\\*\\s*sql\\s*\\*/$")
 (#set! injection.language "sql"))
