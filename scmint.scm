;;; ((pp _+) 3 2) まで
(define (_scmint)
  (let ((program '())
        (result '()))
    (_system-initialize)
    (do ()
        ((eq? result 'quit) 'quit)
      (set! program (read))
      (set! result (_eval program top-level-environment))
      (print result))))

(define (_constant? prog)
  (or (string? prog)
      (number? prog)))

(define (top-level-environment) ())

(define (_system-initialize) 1)

(define (_pp? prog)
  (and (pair? prog) (eq? 'pp (car prog))))

(define (_lambda? prog)
  (and (pair? prog) (eq? 'lambda (car prog))))

(define (_eval-args args env)
  (map (lambda (arg) (_eval arg env)) args))

(define (_apply func args env)
  (cond ((_pp? func)
         (apply (eval (cadr func) (interaction-environment)) (list args)))
;        ((_lambda? func)
;         )
        (else
         (_scm_error (list "unknown function type" func)))))

(define (_+ args)
  (+ (car args) (cadr args)))

(define (_eval prog env)
  (cond ((_constant? prog) prog)
        ((_pp? prog) prog)         ;; 組み込み関数値
        ((_lambda? prog) prog)     ;; ユーザ定義関数
        ;;((_variable? prog) (_lookup-var-val prog env))
        ;;((key-word? prog) (key-word-eval prog env))
        (else
         (_apply (_eval (car prog) env)
                 (_eval-args (cdr prog) env)
                 env))))
