;;; テキストより
(define (cons x y)
  (define (dispatch m)
    (cond ((= m 0) x)
          ((= m 1) y)
          (else (error "Argument not 0 or 1 -- CONS" m))))
  dispatch)

(define (car z) (z 0))
(define (cdr z) (z 1))

(car (cons 100 101))
(cdr (cons 100 101))

;;; 講義より
(define (s-cons x y)
  (define dispatch
    (lambda (m)
      (cond ((eq? m 'car) x)
            ((eq? m 'cdr) y)
            (else 'error "ERROR cons"))))
  dispatch)

(define p (s-cons 100 101))
(p 'car)
(p 'cdr)
(p 'hoge)
