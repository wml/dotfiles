(set-background-color "black")
(set-foreground-color "grey")
(set-frame-font "-*-dejavu sans mono-*-*-*-*-12-*-*-*-*-*-*-*")

;;; death to tabs
(setq-default c-basic-indent 2)
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;;; Fix junk characters in shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq column-number-mode 1)
(menu-bar-mode 0)

(add-hook 'find-file-hooks 'auto-insert)
      (load-library "autoinsert")
      (setq auto-insert-directory "~/.emacs-insert-templates/")
      (setq auto-insert-alist
            (append '(
	          (python-mode      .  "python.inc")
	          (sh-mode          .  "sh.inc")
	          (c-mode           .  "c.inc")
	          (c++-mode         .  "c++.inc")
            )
            auto-insert-alist))
