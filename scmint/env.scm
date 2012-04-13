;; environment

(define (extend-environment vars vals env)
  (cons (make-frame vars vals) env))

(define (lookup-var-val var env)
  (cond ((null? env) (_scm-error (list "undefined variable" var)))
        ((lookup-var var (first-frame env))
         (frame-lookup-var-val var (first-frame env)))
        (else
         (lookup-var-val var (rest-env env)))))


(define (define-env var val env)
  (let ((bound (lookup-var var (first-frame env))))
    (if bound
     (binding-set! bound val)
     (set-car!
      env
      (cons (make-binding var val)
            (first-frame env))))))

(define (first-frame env)
  (car env))

(define (rest-env env)
  (cdr env))

;; frame

(define (make-frame vars vals)
  (cond ((null? vars) ())
        (else (cons (make-binding (car vars) (car vals))
                    (make-frame (cdr vars) (cdr vals))))))

(define (lookup-var var frame)
  (cond ((null? frame) #f)
        ((binding-eq? var (first-binding frame))
         (first-binding frame))
        (else
         (lookup-var var (cdr frame)))))

(define (frame-lookup-var-val var frame)
  (cond ((null? frame) #f)
        ((binding-eq? var (first-binding frame))
         (binding-val (first-binding frame)))
        (else
         (frame-lookup-var-val var (cdr frame)))))

(define (first-binding frame)
  (car frame))

;; binding

(define (make-binding var val)
  (cons var val))

(define (binding-eq? var bound)
  (eq? var (binding-var bound)))

(define (binding-var bound)
  (car bound))

(define (binding-val bound)
  (cdr bound))

(define (binding-set! bound val)
  (set-cdr! bound val))
