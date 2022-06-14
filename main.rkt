#lang racket/base

(module+ test
  (require rackunit))

(module+ test
  (check-equal? (+ 2 2) 4))

(module+ main
  (require "lang/reader.rkt")
  (provide read-syntax))
  