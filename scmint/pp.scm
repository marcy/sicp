;; primitive procedure

(define (_+ args)
  (+ (car args) (cadr args)))

(define-env '+ (_pp-new '_+) toplevel-environment)

(define (_- args)
  (- (car args) (cadr args)))

(define (_* args)
  (* (car args) (cadr args)))

(define-env '* (_pp-new '_*) toplevel-environment)

(define-env '- (_pp-new '_-) toplevel-environment)

(define (_< args)
  (< (car args) (cadr args)))

(define-env '< (_pp-new '_<) toplevel-environment)

(define (_> args)
  (> (car args) (cadr args)))

(define-env '> (_pp-new '_>) toplevel-environment)

(provide "pp")
