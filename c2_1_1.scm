;;; rational number operator interface
(define +-rat (r1 r2)
  (make-rat
(define --rat (r1 r2)

(define (*-rat r1 r2)
  (make-rat (* (numerator r1)
               (numerator r2))
            (* (denominator r1)
               (denominator r2))))

(define /-rat (r1 r2)

;;;
(define (make-rat n d)
  (cons n d))

(define (numerator r)
  (car r))

(define (denominator r)
  (cdr r))

;;;
(define r (make-rat 1 2))
(*-rat r r)
