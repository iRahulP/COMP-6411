
(defun consR (lst elt)
  (cond ((null lst) (cons elt nil)
        (t (cons (car lst) (consR (cdr lst) elt)))
)))

(defun fn ( arg )
  (typecase arg
    (cons 'append)
    (number '+)))

(defun combine (&rest args)
(apply (fn (car args)) args))

(defun combine-max (lst1 lst2)
  (cond ((null lst1) lst2)
        ((null lst2) lst1)
        ((> (car lst1) (car lst2)) (cons (car lst1) (combine-max (cdr lst1) (cdr lst2))))
        (t (cons (car lst2) (combine-max (cdr lst1) (cdr lst2))))
))

(defun dist (n lst)
  (cond ((null lst) nil)
        (t (cons (list n (car lst)) (dist n (cdr lst))))
))

;(setq testlist (cons 'a '(a b b c d e a)))

(defun is-in-list (lst elmnt)
    (loop for x in lst do
        (if (eq x elmnt) 
            (return-from is-in-list t))
    )
    (return-from is-in-list nil)
)

(defun rem-if-dupl (dupl)
    (setq newlist '())   
    (loop for x in dupl do 
        (if (not (is-in-list newlist x))
                (setq newlist (consR newlist x))))
    (return-from rem-if-dupl newlist))

;(format t "~S" (rem-if-dupl testlist))


(defun oseq (n)
    (if (not (integerp n)) 
        (return-from oseq nil))
    (setq newlist '())
    (loop for i from 0 to (- n 1) do
        (if (oddp i)
            (setq newlist (consR newlist i))))
    (return-from oseq newlist))