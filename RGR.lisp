(defun F1-F20 ()
  (let ((res-list '(1.0))
        (f-prev 1))
    (do ((i 2 (incf i)))
        ((> i 20) (nreverse res-list))
      (cond
        ((< i 11) (setf f-prev (+ (log f-prev) (/ i 2.0))))
        ((= i 11) (setf f-prev 1))
        (t (setf f-prev (* 2 (cos (+ f-prev (sin (* 2 i))))))))
        (push f-prev res-list))))

(defun my-print (inp-list)
  (format t "   F(i)       Result~%")
  (format t "-------------------------~%")
  (loop for val in inp-list
        for i from 1
        do (format t "   F(~2d)  ~15,5f~%" i val)))

(defun RGR ()
  (let ((result-list (F1-F20)))
    (my-print result-list)))





(defun read-cpp-file (filename)
  (let ((result nil))
    (with-open-file (stream filename :if-does-not-exist nil)
      (if stream
          (loop for num = (read stream nil 'eof)
                until (eq num 'eof)
                do (push num result))
          (format t "ERROR: File ~s not found!~%" filename)))
    (nreverse result)))

(defun check-equals (val1 val2)
  (let ((epsilon 0.0001))
    (< (abs (- val1 val2)) epsilon)))

(defun test-case (index lisp-val cpp-val)
  (if (check-equals lisp-val cpp-val)
      (progn
        (format t "Test [~2d]: OK~%" index)
        t)
      (progn
        (format t "Test [~2d]: FAIL! (Lisp: ~5,3f != C++: ~5,3f)~%" index lisp-val cpp-val)
        nil)))

(defun run-tests ()
  (format t "~%--- STARTING TESTS ---~%")
  
  (let ((lisp-data (F1-F20))
        (cpp-data  (read-cpp-file "cpp_results.txt"))
        (errors 0))
    
    (when (/= (length lisp-data) (length cpp-data))
      (format t "CRITICAL ERROR: Different list lengths!~%")
      (return-from run-tests nil))

    (loop for l-val in lisp-data
          for c-val in cpp-data
          for i from 1
          unless (test-case i l-val c-val) do (incf errors))
    
    (format t "----------------------~%")
    (if (= errors 0)
        (format t "RESULT: SUCCESS! All tests passed.~%")
        (format t "RESULT: FAILED! Found ~d errors.~%" errors))))
