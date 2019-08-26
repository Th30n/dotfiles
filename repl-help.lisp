(defun install-linedit ()
  (ql:quickload "linedit")
  (let ((install-repl (find-symbol (string :install-repl) :linedit))
        (highlight-color (find-symbol (string :*highlight-color*) :linedit)))
    (prog1 (funcall install-repl :wrap-current t :eof-quits t)
      (setf (symbol-value highlight-color) :red))))

(defun print-package-symbols (package-designator)
  (do-external-symbols (sym package-designator)
    (print sym)))

(defun describe-package-symbols (package-designator)
  (do-external-symbols (sym package-designator)
    (describe sym)
    (write-line "--------------------------------------------------")))
