#lang racket
(require "lexer.rkt")
(define (read-syntax path port)
  (define parse-tree (read-syntax_ path port))
  (define module-datum `(module rpp-mod rpp/lang/expander
                          ,parse-tree))
                          ;',parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

