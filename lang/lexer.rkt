#lang racket
(require "parser.rkt")
(define (read-syntax_ path port)
  (parse path (make-tokenizer port)))
(provide read-syntax_)

(require brag/support)
(define-lex-abbrev digits (:+ (:/ #\0 #\9)))
(define-lex-abbrev letters (:+ (:or(:/ "a" "z")(:/ "A" "Z"))))
(define-lex-abbrev higher-order-reserved-preconverted-terms (:or "==" "!=" "<=" ">=" "&&" "||"))
(define-lex-abbrev reserved-preconverted-terms (:or "auto" "int" "for"  "if" "else"  "goto"  "print" "cout" "endl" "void" "main"
                                       (char-set "[,.]{}<>=+-*/();:!%")))
(define-lex-abbrev higher-order-preconverted-terms (:or "afterParse" "expandOnceSkip" "expandMSkip" "afterParseSkip" "expandM" "coach"))

(define (make-tokenizer port)
  (define (next-token)
    (define bf-lexer
      (lexer-srcloc
       [(from/to "//" "\n") (next-token)]
       [(from/to "\"" "\"") (token 'STRING (trim-ends "\"" lexeme "\"" ))]
       [(from/to "noparse->" "\n") (token 'NOPARSE (read (open-input-string(trim-ends "noparse->" lexeme "\n"))))] ; work for only one sexp
       [higher-order-preconverted-terms (token lexeme (string->symbol lexeme))]
       [higher-order-reserved-preconverted-terms (token lexeme (string->symbol lexeme))]
       [reserved-preconverted-terms (token lexeme (string->symbol lexeme))]
       [letters (token 'NAME (string->symbol lexeme))]
       [digits (token 'INTEGER (string->number lexeme))]
       [any-char (next-token)]))
    (bf-lexer port))  
  next-token)


