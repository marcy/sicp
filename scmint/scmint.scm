(define toplevel-environment '(()))

(use ggc.debug.trace)
(load "./scminti.scm")
(load "./scmintd.scm")
(load "./env.scm")
(load "./pp.scm")

(define (_scmint)
  (let ((program '())
        (result '()))
    (_system-initialize)
    (do ()
        ((eq? result 'quit) 'quit)      ; 終了条件
      (set! program (_read))
      (set! result (_toplevel-eval program toplevel-environment))
      (_print result))))

(define (_system-initialize)
)

(define (_toplevel-eval prog env)
  (with-error-handler
   (lambda (e)                               ; 例外処理手続き
     (_print (list '_scmint-error e))
     'error)
   (lambda ()
     (_eval prog env))))

(define (_scm-error mesg)               ; エラー例外を発生させる
  (raise mesg))

(provide "scmint")
