#lang info
(define collection "rpp")
(define deps '("brag-lib"
               "optimization-coach"
               "typed-racket-lib"
               "base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/rpp.scrbl" ())))
(define pkg-desc "Description Here")
(define version "0.0")
(define pkg-authors '(mimoanon))
(define license '(MIT))
