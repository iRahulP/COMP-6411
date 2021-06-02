(defun consR (lst elt)
  (cond ((null lst) (cons elt nil))
        (t (cons (car lst) (consR (cdr lst) elt)))
))

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

(defun remove-elt (elt lst)
  (cond ((null lst) nil)
        ((equal (car lst) elt) (remove-elt elt (cdr lst)))
        (t (cons (car lst) (remove-elt elt (cdr lst))))))


(defun rem-if-dupl (lst)
  (cond ((null lst) nil)
        ((member (car lst) (cdr lst)) (remove-elt (car lst) lst))
        (t (cons (car lst) (rem-if-dupl (cdr lst))))))
