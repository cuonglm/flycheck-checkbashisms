;;; flycheck-checkbashisms-test.el --- flycheck-checkbashisms test cases  -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Cuong Le

;; Author: LE Manh Cuong <cuong.manhle.vn@gmail.com>
;; URL: https://github.com/Gnouc/flycheck-checkbashisms

;;; Commentary:

;; Test cases for flycheck-checkbashisms

;;; Code:

(require 'flycheck-checkbashisms)
(require 'flycheck-ert)

(message "Running tests on Emacs %s" emacs-version)

(defconst flycheck-checkbashisms-test-directory
  (let ((filename (if load-in-progress load-file-name (buffer-file-name))))
    (expand-file-name "test/" (locate-dominating-file filename "Cask")))
  "Test suite directory.")

(flycheck-ert-def-checker-test sh-checkbashisms sh error
  (let ((flycheck-checkers '(sh-checkbashisms)))
    (flycheck-ert-should-syntax-check
     "checkbashisms.sh" 'sh-mode
     '(4 nil error "('printf -v var ...' should be var='$(printf ...)')"
         :checker sh-checkbashisms))))

(flycheck-ert-initialize flycheck-checkbashisms-test-directory)

(provide 'flycheck-checkbashisms-test)
;;; flycheck-checkbashisms-test.el ends here
