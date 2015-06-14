(in-package :lem)

(defvar *tblist* nil)

(defun tblist-add (tb)
  (push tb *tblist*)
  tb)

(defun tblist-any-modif-p ()
  (find-if 'textbuf-modif-p *tblist*))

(defun tblist-find (name)
  (find-if (lambda (textbuf)
             (string= name (textbuf-name textbuf)))
    *tblist*))

(add-command 'tblist-select 'select-buffer "C-xb")
(defun tblist-select (buffer arg)
  (let* ((name (mb-readline "Use buffer: "))
         (tb (tblist-find name)))
    (buffer-change-textbuf buffer tb)
    t))

(add-command 'tblist-kill 'kill-buffer "C-xk")
(defun tblist-kill (buffer arg)
  (let* ((name (mb-readline "Kill buffer: "))
         (tb (tblist-find name)))
    (when (cdr *tblist*)
      (dolist (b *window-list*)
        (when (eq tb (buffer-textbuf b))
          (tblist-next b nil)))
      (setq *tblist* (delete tb *tblist*))))
  t)

(add-command 'tblist-next 'next-buffer "C-xx")
(defun tblist-next (buffer arg)
  (arg-repeat (arg t)
    (let ((tb (cadr (member (buffer-textbuf buffer) *tblist*))))
      (buffer-change-textbuf buffer (or tb (car *tblist*))))))
