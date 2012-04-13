(define (_eval prog env)
  (cond ((_constant? prog) prog)
        ((_pp? prog) prog)                                   ;; 組み込み関数値
        ((_closure? prog) prog)
        ((_variable? prog) (lookup-var-val prog env))
        ((_lambda? prog) (_closure-new prog env))            ;; ユーザ定義関数
        ((_delay? prog) (_closure-new (list (car prog) () (cadr prog)) env))
        ((_force? prog) (_eval (cdr prog) env))
        ((_keyword-exp? prog) (_keyword-exp-eval prog env))
        (else
         (_apply (_eval (car prog) env)
                 (_eval-args (cdr prog) env)
                 env))))

(define (_eval-args args env)
  (map (lambda (arg) (_eval arg env)) args))

(define (_apply func args env)
  (cond ((_pp? func)
         (_pp-apply func args))
        ((_closure? func)
         (_eval (_closure-body func)
                (extend-environment (_closure-formals func)
                                    args
                                    (_closure-env func))))
        (else
         (_scm-error (list "unkown function type" func)))))

(define (_keyword-exp-eval exp env)
  (cond ((eq? 'quote (car exp))
         (_quote exp env))
        ((eq? 'if (car exp))
         (_if exp env))
        ((eq? 'cond (car exp))
         (_cond exp env))
        ((eq? 'def (car exp))
         (_define exp env))
        (else
         (_scm-error (list "unknown keywords" exp)))))

(define (_quote exp env)
  (cadr exp))

(define (_if exp env)
  (let ((c (_eval (cadr exp) env))
        (then (caddr exp))
        (else (cdddr exp)))
    (if c
        (_eval then env) ;; then exp
        (if else
            (_eval (car else) env)
            #t))))

(define (_cond exp env)
  (define (exec exp env)
    (let ((condition (caar exp))
          (body (cadar exp))
          (next (cdr exp)))
      (if (eq? 'else condition)
          (_eval body env)
          (if (_eval condition env)
              (_eval body env)
              (exec next env)))))
  (exec (cdr exp) env))

(define (_define exp env)
  (define-env (cadr exp) (_eval (caddr exp) env) env))

(provide "scminti")
