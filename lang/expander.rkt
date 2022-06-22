#lang racket
;third block of for is not properly checking the before = stuff
;break not working
(require optimization-coach)
;try expand-once
;try expand-to-top-form
(provide  #%module-begin)
(provide  #%datum)
(provide  #%top)
(provide  #%app)
(provide  quote)

(define-syntax-rule (bf-program x ...)
  [begin_ x ...])
(define-syntax-rule (function name args ... (b ...))
  (define (name args ...)(b ...)))

(define-syntax for_oper_standart
  (syntax-rules ()
   [(for_oper_standart x1 x2 y z w) (do ([x1 x2 z])((not y)) w )]
    ))
(define-syntax for_oper_in_range
  (syntax-rules ()
   [(for_oper_in_range x1 x2 y) (for ([x1 x2]) y )]
    ))


(define-syntax if_oper
  (syntax-rules ()
   [(if_oper x y z) (if x y z)]
   [(if_oper x y) (if_oper x y void)]
    ))

(define-syntax begin_
  (syntax-rules ()
   [(begin_) (void)   ]
   [(begin_ x ... )  (begin x ...)  ]
    ))

(define-syntax-rule (c_set x y)
  (set! x y))
; for chained =
(define-syntax let_
  (syntax-rules (c_let)
   [(let_ ( (y (c_let p1 p2)) x ... )(z ...)) (let_ ( ( p1 p2) (y p1) x ...  )(z ...))   ]
   [(let_ x ... )  (let*  x ...)  ]
    ))
; moving commands after let to inside of it brackets
(define-syntax block_
  (syntax-rules (c_let)
   [(block_ (l ...)  z ... (c_let p p2)) (block_ (begin_ (let_ ([p p2])(l ...))) z ...)]
   [(block_ (t l ...)  z ... x) (block_ (t x l ... ) z ...)]
   {(block_ (l ...) z ...) (begin_( l ...)  z ...)}
    ))
(define-syntax block
  (syntax-rules ()
   [(block  z ...) (block_ (begin_ ) z ...)]
    ))

(define-syntax macro
  (syntax-rules ()
   [(macro  z ...) (z ...)]
    ))

(define-syntax-rule (expandM  z ...)
   (begin (writeln [expand #'(begin z ...)])(begin z ...)))
    
(define-syntax-rule (expandMSkip  z ...)
   (writeln [expand #'(begin z ...)]))

(define-syntax-rule (afterParse  z ...)
   (begin (writeln  #'(begin z ...))(begin z ...)))

(define-syntax-rule (afterParseSkip  z ...)
  (writeln  #'(begin z ...)))

(define-syntax-rule (expandOnceSkip  z ...)
   (writeln [expand-once #'(begin z ...)]))

(define-syntax-rule (coach y ...)
  (optimization-coach-profile y ...))

(define-syntax simple_list_comp
  (syntax-rules (dot_placeholder)
   [(simple_list_comp  z (dot_placeholder) x) (in-range z (+ x 1) 1)]
   [(simple_list_comp  z y (dot_placeholder) x) (in-range z (+ x 1) (- y z))]
   [(simple_list_comp  z ...) (list z ...)]
    ))
(require "utils.rkt")
(populate-with-digits 15 (binop x y z) (y x z) )

(define-syntax-rule (&& x y)
  (and x y))

(define-syntax-rule (|| x y)
  (or x y))

(define-syntax-rule (== x y)
  (equal? x y))

(define-syntax-rule (!= x y)
  (not(equal? x y)))

(define-syntax c_print_intern
  (syntax-rules (endl)
   [(c_print_intern endl) (displayln "")]
   [(c_print_intern x) (write x)]
    ))

(define-syntax-rule (% x y)
  (remainder x y))
(define-syntax-rule (/ x y)
  (quotient x y))
(define-syntax-rule (c_set_global x y )
  (define x y))

(define-syntax-rule (apply x ...)
  (x ...))
(define-syntax-rule (index_ y ...)
  (list-ref y ...))
(require brag)
(require 2htdp/image)
(provide (all-from-out 2htdp/image))
(provide (all-defined-out))
(provide sqrt)
(provide + * - > < >= <=)