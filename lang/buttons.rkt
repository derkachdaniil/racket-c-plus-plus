#lang racket
(require racket/draw)

(define (button-func drr-window)
  (define expr-string "for(auto i = 0;i < 10;i = i + 1)\n{\n")
  (define expr-string2 "\n}")
  (define editor (send drr-window get-definitions-text))
  (define pos2 (send editor get-end-position))
  (define pos (send editor get-start-position))
  (send editor insert expr-string2 pos2)
  (send editor insert expr-string pos))

(define (add-for-button)
   (define icon (make-object bitmap% 16 16))
   (send icon load-file "3.png") 
  (list
   "Insert for 10"
   icon
   button-func
   #f))

(provide button-list)
(define button-list (list (add-for-button)))   