#lang racket

(require syntax/parse/define)

(define-syntax-parser populate-with-digits
  [(populate-with-digits 0 _ _ z ...)
   #'(begin z ...)]
  [(populate-with-digits repeats (name parameters ...) code z ...)
   #:with nname (string->symbol(string-append (symbol->string(syntax->datum #'name))
                                                                         (number->string (syntax->datum #'repeats ))))
   #:with repeats-1 (- (syntax->datum #'repeats) 1)
   (datum->syntax this-syntax(syntax->datum #'(populate-with-digits repeats-1 (name parameters ...) code  z ... (define-syntax-rule (nname parameters ...) code)  )))])
(provide populate-with-digits)