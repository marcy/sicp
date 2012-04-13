(define (_scmint)
  (let ((program '())
	(result '()))
    (_system-initialize)
    (do ()
	((eq? result 'quit) 'quit)
      (set! program (read))
      (set! result (_eval program top-level-environment))
      (print result))))

(define top-level-environment ())

(define (_system-initialize) 1)

(define (_eval prog env)
  (cond ((_constant? prog) prog)
	((_pp? prog) prog)                          ;; 組み込み関数値
	((_lambda? prog) (_make-lambda prog env))   ;; ユーザ定義関数
        ((_variable? prog) (_lookup-var-val prog env))
	((_keyword-exp? prog) (_keyword-exp-eval prog env))
	(else 
	 (_apply (_eval (car prog) env)
		 (_eval-args (cdr prog) env)
		 env))))

(define (_keyword-exp? exp)
  (or (eq? 'quote (car exp))
      (eq? 'if (car exp))
      (eq? 'define (car exp))
      (eq? 'cond (car exp))))

(define (_keyword-exp-eval exp env)
  (cond ((eq? 'quote (car exp))
         (_quote exp env))
        ((eq? 'if (car exp))
         (_if exp env))
        (else
         (_scm_error (list "unknown keywords" exp)))))

(define (_if exp env)
  (let ((c (_eval (cadr exp) env))
        (then (caddr exp))
        (else (cdddr exp)))
    (if c
        (_eval then env)  ;; then exp
        (if else
            (_eval else env)
            #t))))

(define (_quote exp env)
  (cadr exp))

(define (_make-lambda prog env)
  (if (eq? 'lambda (car prog))
      (list 'lambda (list (cadr prog) (cddr prog)) env))
  
(define (_eval-args args env) 
  (map (lambda (arg) (_eval arg env)) args))

(define (_apply func args env)
  (cond ((_pp? func)
	 (apply (eval (cadr func) (interaction-environment)) (list args))
	 )
	((_lambda? func)
         (let ((body (_lambda-exp-body func))
               (newenvironment (extend-environment (_lambda-exp-formals func)
                                                   args
                                                   (_lambda-exp-env func))))
           (_eval body newenvironment))
         (_eval body newenvironment)
	 )
	(else
	 (_scm_error (list "unkown function type" func)))))

(define (_+ args)
  (+ (car args) (cadr args)))

(define (_constant? prog) 
  (or  (string? prog) 
       (number? prog)))

(define (_pp? prog) 
  (and (pair? prog) (eq? 'pp (car prog))))

(define (_lambda? prog) 
  (and (pair? prog) (eq? 'lambda (car prog))))
