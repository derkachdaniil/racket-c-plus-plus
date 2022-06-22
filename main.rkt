;        for (int j = 1; j < 10344; j = j + 2) create error with unknown location
#lang racket/base

(module+ test
  (require rackunit))

(module+ test
  (check-equal? (+ 2 2) 4))

(module+ reader
  (require "lang/reader.rkt")
  (require "lang/buttons.rkt")
  ;(require "lang/indenter.rkt")
  (provide read-syntax get-info)
  (define (get-info port src-mod src-line src-col src-pos)
    (define (handle-query key default)
      (case key
        [(color-lexer) color-rpp]
        #;[(drracket:indentation) indent-rpp]
        [(drracket:toolbar-buttons) button-list]
        [else default]))
    handle-query))
  