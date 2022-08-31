#lang racket
;putting /* before */ not working - no proper backtrack

(require brag/support)
(define-lex-abbrev digits (:+ numeric "."))
(define-lex-abbrev letters (:+ (:or alphabetic numeric (char-set "<>=+-*$№/%?_"))))
(define-lex-abbrev higher-order-reserved-preconverted-terms (:or "==" "!=" "<=" ">=" "&&" "||" "<<"))
(define-lex-abbrev reserved-preconverted-terms (:or "auto" "int" "for"  "if" "else"  "goto"  "print" "cout" "endl" "void" "main"
                                       (char-set "[,.]{}<>=+-*/();:!%")))
(define-lex-abbrev higher-order-preconverted-terms (:or "afterParse" "expandOnceSkip" "expandMSkip" "afterParseSkip" "expandM" "coach"))

(define (make-tokenizer port)
  (define (next-token)
    (define bf-lexer
      (lexer-srcloc
       [(from/to "//" "\n") (next-token)]
       [(from/to "/*" "*/") (next-token)]
       [(from/to "\"" "\"") (token 'STRING (trim-ends "\"" lexeme "\"" ))]
       [(from/to "noparse->" "\n") (token 'NOPARSE (read (open-input-string(trim-ends "noparse->" lexeme "\n"))))] ; work for only one sexp
       [higher-order-preconverted-terms (token lexeme (string->symbol lexeme))]
       [higher-order-reserved-preconverted-terms (token lexeme (string->symbol lexeme))]
       [reserved-preconverted-terms (token lexeme (string->symbol lexeme))]
       [digits (token 'INTEGER (string->number lexeme))]
       [letters (token 'NAME (string->symbol lexeme))]
       [any-char (next-token)]))
    (bf-lexer port))  
  next-token)

(provide make-tokenizer)

(define rpp-lexer
  (lexer
   [(eof) (values lexeme 'eof #f #f #f)]
   [(from/to "//" "\n")
    (values lexeme 'comment #f
            (pos lexeme-start) (pos lexeme-end))]
   [(from/to "/*" "*/")
    (values lexeme 'comment #f
            (pos lexeme-start) (pos lexeme-end))]
   [(from/to "\"" "\"")
    (values lexeme 'string #f
            (pos lexeme-start) (pos lexeme-end))]
   [digits
    (values lexeme 'constant #f
            (pos lexeme-start) (pos lexeme-end))]
   [(:or "(" ")")
    (values lexeme 'parenthesis
            (if (equal? lexeme "(") '|(| '|)|)
            (pos lexeme-start) (pos lexeme-end))]
   [(:or "{" "}")
    (values lexeme 'parenthesis
            (if (equal? lexeme "{") '|{| '|}|)
            (pos lexeme-start) (pos lexeme-end))]
   [(:or "[" "]")
    (values lexeme 'parenthesis
            (if (equal? lexeme "[") '|[| '|]|)
            (pos lexeme-start) (pos lexeme-end))]
   #;[higher-order-reserved-preconverted-terms
    (values lexeme 'sexp-comment #f
            (pos lexeme-start) (pos lexeme-end))]
   #;[higher-order-preconverted-terms
    (values lexeme 'sexp-comment #f
            (pos lexeme-start) (pos lexeme-end))]
   #;[reserved-preconverted-terms
    (values lexeme 'sexp-comment #f
            (pos lexeme-start) (pos lexeme-end))]
   [letters
    (values lexeme 'symbol #f
            (pos lexeme-start) (pos lexeme-end))]
   [any-char
    (values lexeme 'symbol #f
            (pos lexeme-start) (pos lexeme-end))]))
(provide rpp-lexer)

