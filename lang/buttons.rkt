#lang racket
(require racket/draw)

(define (button-func-main drr-window)
  (define expr-string "void main()\n{\n")
  (define expr-string2 "\n}")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))

(define (button-if-func drr-window)
  (define expr-string "if()\n{\n")
  (define expr-string2 "\n}\n else \n {\n}")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))


(define (button-func drr-window)
  (define expr-string "for(auto i = 0;i < 10;i = i + 1)\n{\n")
  (define expr-string2 "\n}")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))

(define (button-var-func drr-window)
  (define expr-string "auto x = ")
  (define expr-string2 "")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))

(define (button-circle-func drr-window)
  (define expr-string "circle (30,\"outline\",\"red\");")
  (define expr-string2 "")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))

(define (button-rectangle-func drr-window)
  (define expr-string "rectangle (30,40,\"solid\",\"green\");")
  (define expr-string2 "")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))

(define (add-for-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "For 10"
   icon
   button-func
   #f))

(define (add-main-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "Main"
   icon
   button-func-main
   #f))

(define (add-if-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "If"
   icon
   button-if-func
   #f))

(define (add-var-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "Var"
   icon
   button-var-func
   #f))

(define (add-rectangle-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "circle"
   icon
   button-circle-func
   #f))

(define (add-circle-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "rectangle"
   icon
   button-rectangle-func
   #f))


(provide button-list)
(define button-list (list (add-for-button) (add-main-button) (add-if-button) (add-var-button) (add-circle-button) (add-rectangle-button)))   