;; Question 1
(defun consR (lst elt)
    (cond   ((null lst) (cons elt nil))
            (t (cons (car lst) (consR (cdr lst) elt)))
    )
)

;; (consR '(a b c) 'd)


;; Question 2
(defun fn (arg) 
    (if (typep arg 'number) 
        '+   
        'append 
    )
)

(defun combine (&rest args)
    (apply (fn (car args )) args)
)

;; (combine 2 3 4)
;; (combine '(a b) '(c d))


;; Question 3
(defun combine-max (lst1 lst2)
    (cond   ((null lst1) lst2)
            ((null lst2) lst1)
            ((> (car lst1) (car lst2)) (cons (car lst1) (combine-max (cdr lst1) (cdr lst2))))
            (t (cons (car lst2) (combine-max (cdr lst1) (cdr lst2))))
    )
)

;; (combine-max '(4 6 8 9 2) '(5 1))
;; (combine-max '(3 4 5) '(1 2 3))
;; (combine-max '() '(6 1 9))


;; Question 4
(defun dist (n lst)
    (cond   ((null lst) nil)
            (t (cons (list n (car lst)) (dist n (cdr lst))))
    )
)

;; (dist 'a '(b c d))


;; Question 5
(defun remove-all-occurences (elt lst)
    (cond   ((null lst) nil)
            ((equal (car lst) elt) (remove-all-occurences elt (cdr lst)))
            (t (cons (car lst) (remove-all-occurences elt (cdr lst))))
    )
)

(defun member2 (item lst)
    (if lst
        (if (eql item (car lst))
          T
          (member2 item (cdr lst))
        )
    )
)

(defun rem-if-dupl (lst)
    (cond   ((null lst) nil)
            ((member2 (car lst) (cdr lst)) (remove-all-occurences (car lst) lst))
            (t (cons (car lst) (rem-if-dupl (cdr lst))))
    )
)

;; (rem-if-dupl nil)
;; (rem-if-dupl '(1 1))
;; (rem-if-dupl '(1 2 2 3 4))
;; (rem-if-dupl '(1 2 3 4))
;; (rem-if-dupl '(1 2 3 4 2))


;; Question 6
(defun oseq (n)
    (if (> n 0)
        (if (oddp (- n 1)) 
            (consR (oseq (- n 1)) (- n 1))
            (oseq (- n 1))
        )   
    )
)

;; (oseq 1)
;; (oseq 2)
;; (oseq 10)
;; (oseq 11)


;; Question 7
(defun filter (lst elt)
    (cond   ((not (listp lst)) nil)
            ((not (integerp elt)) nil)
            ((null lst) nil)
            ((not (> elt 0)) nil)
            ((> (car lst) elt) (cons (car lst) (filter (cdr lst) elt)))
            (t (filter (cdr lst) elt))
    )
)

;; (filter '5 3)
;; (filter '() 5)
;; (filter '(7 9 11) '(2))
;; (filter '(3 4 5) '0)
;; (filter '(3 4 5) '2.5)
;; (filter '(3 4 5) '0)
;; (filter '(5 9 3 2 11) '7)


;; Question 8
(defun is-valid-bst (tree)
    (let ((root (car tree)))
    (let ((left-sub-tree-node-key (car (car (cdr tree)))))
    (let ((right-sub-tree-node-key (car (car (cdr (cdr tree))))))
    (let ((left-sub-tree (car (cdr tree))))
    (let ((right-sub-tree (car (cdr (cdr tree)))))
         
        (if (and (not (eq left-sub-tree () )) (not (eq right-sub-tree () )))
            (if (and (>= root left-sub-tree-node-key)  (< root right-sub-tree-node-key))
                (progn
                    (is-valid-bst left-sub-tree)
                    (is-valid-bst right-sub-tree)
                )            
                (setq result 1)              
            )         
        )         
                
        (if  (and (not (eq left-sub-tree () ))  (eq right-sub-tree () ))
            (if (>= root left-sub-tree-node-key) 
                (is-valid-bst left-sub-tree)         
                (setq result 1) 
            )          
        )         
                
        (if (and (eq left-sub-tree () ) (not (eq right-sub-tree () )))
            (if (< root right-sub-tree-node-key)         
                (is-valid-bst right-sub-tree) 
                (setq result 1)
            )
        )           
        
        (if (and (eq left-sub-tree () ) (eq right-sub-tree () ))
            (return-from is-valid-bst)
        )

    )))))
)

(defun is-bst (tree)
    (progn
        (setq result 0)        
        (is-valid-bst tree )
        (if (= result 0)
            (return-from  is-bst "YES")
            (return-from is-bst "NO")
        )    
    )
)

;; (is-bst '() )
;; (is-bst '(1 (0)) )
;; (is-bst '(1 (0) (3)) )
;; (is-bst '(1 (2)) ) )
;; (is-bst '(1 (0) (3 (4))) )


;; Question 9
(defun max1 (a b)
    (if (> a b)
        a 
        b
    )
)

(defun height (tree) 
    (let ((left-sub-tree (car (cdr tree))))
    (let ((right-sub-tree (car (cdr (cdr tree)))))

        (cond   ((null tree) 0)
                (t (+ 1 (max1 (height left-sub-tree) (height right-sub-tree) )))
        )
    ))
)

;; (height '(1 (0) (3 () (5))) )


;; Question 10
(defun post-order-traversal (tree)
    (let ((root (car tree)))
    (let ((left-sub-tree (car (cdr tree))))
    (let ((right-sub-tree (car (cdr (cdr tree)))))
         
        (if (not (eq tree () ))
            (append
                (post-order-traversal left-sub-tree)
                (post-order-traversal right-sub-tree)
                (list root)
            )                      
        )                          
    )))
)

;; (post-order-traversal '(40 (30 (25 () ())(35 () ()))(60 (50 () ())())) )