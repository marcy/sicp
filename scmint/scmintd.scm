;;
;; I/O:
;;   data structure input and output
;;

(define (_read)            ; input
  (read))

(define (_print avalue)    ; output
  (print avalue))

;; constant
(define (_constant? prog)
  (or (string? prog)
      (number? prog)
      (eq? #t prog)
      (eq? #f prog)))

;; variable
(define (_variable? prog)
  (symbol? prog))

;; primitive procedures:
;;   '(pp aName)
(define (_pp? prog)
  (and (pair? prog)
       (eq? 'pp (car prog))))

(define (_pp-new aName)
  (list 'pp aName))

(define (_pp-body app)
  (cadr app))

(define (_pp-apply ppdef args)
  (apply (eval (_pp-body ppdef) (interaction-environment)) (list args)))

;;
;; closure:
;;  '(closure formals body env)
;;
(define (_closure? prog)
  (and (pair? prog)
       (eq? '_closure (car prog))))

(define (_closure-new prog env)
  (list '_closure (cadr prog) (caddr prog) env))

(define (_closure-formals c)
  (and (_closure? c) (cadr c)))

(define (_closure-body c)
  (and (_closure? c) (caddr c)))

(define (_closure-env c)
  (and (_closure? c) (cadddr c)))

;; lambda
(define (_lambda? prog)
  (and (pair? prog) (eq? 'fn (car prog))))

;; delay
(define (_delay? prog)
  (and (pair? prog) (eq? 'delay (car prog))))

;; force
(define (_force? prog)
  (and (pair? prog)
       (eq? 'force (car prog))))

;; keyword
(define (_keyword-exp? exp)
  (or (eq? 'quote (car exp))
      (eq? 'if (car exp))
      (eq? 'cond (car exp))
      (eq? 'def (car exp))))

(provide "scmintd.scm")
