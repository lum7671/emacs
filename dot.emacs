; (server-start)

;; Cask
(require 'cask "/Users/1001028/.emacs.d/.cask/26.1/elpa/cask-20180626.1949/cask.elc")
(cask-initialize)


(let ((default-directory  "~/.emacs.d/.cask"))
  (normal-top-level-add-subdirs-to-load-path))


;; =============================================================================
;; 기본 색 지정
;; =============================================================================

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Some people have reported problems when pasting from other OS X applications if they have set the command key as Meta, because Emacs always uses its internal killring for C-y etc. You may merge the Emacs kill-ring with the clipboard via:
(setq x-select-enable-clipboard t)


(when (eq system-type 'darwin)

  ;; default Latin font (e.g. Consolas)
  (set-face-attribute 'default nil :family "Hack")

  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly.
  (set-face-attribute 'default nil :height 120)

  ;; use specific font for Korean charset.
  ;; if you want to use different font size for specific charset,
  ;; add :size POINT-SIZE in the font-spec.
  (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))

  ;; you may want to add different for other charset in this way.
  )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))


(require 'ansi-color)

(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(defadvice display-message-or-buffer (before ansi-color activate)
  "Process ANSI color codes in shell output."
  (let ((buf (ad-get-arg 0)))
    (and (bufferp buf)
         (string= (buffer-name buf) "*Shell Command Output*")
         (with-current-buffer buf
           (ansi-color-apply-on-region (point-min) (point-max))))))

;; Python

(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;(setenv "LC_CTYPE" "UTF-8")
;(setenv "LC_ALL" "en_US.UTF-8")
;(setenv "LANG" "en_US.UTF-8")

(setenv "LANG" "ko_KR.UTF-8")
(setenv "LC_ALL" "ko_KR.UTF-8")
(setenv "LC_COLLATE" "ko_KR.UTF-8")
(setenv "LC_CTYPE" "ko_KR.UTF-8")
(setenv "LC_MESSAGES" "ko_KR.UTF-8")
(setenv "LC_MONETARY" "ko_KR.UTF-8")
(setenv "LC_NUMERIC" "ko_KR.UTF-8")
(setenv "LC_TIME" "ko_KR.UTF-8")

;(elpy-enable)

(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(setq gud-pdb-command-name "python -m pdb")

;; PDB command line
(defun user-python-debug-buffer ()
  "Run python debugger on current buffer."
  (interactive)
  (setq command (format "python -u -m pdb %s " (file-name-nondirectory buffer-file-name)))
  (let ((command-with-args (read-string "Debug command: " command nil nil nil)))
    (pdb command-with-args)))

(setq exec-path (split-string (getenv "PATH") path-separator))

;; Enable plantuml-mode for PlantUML files
(add-to-list 'auto-mode-alist '("\\.plantuml\\'" . plantuml-mode))
(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(blink-cursor-mode t)
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (wheatgrass)))
 '(default-input-method "korean-hangul3f")
 '(display-battery-mode t)
 '(display-time-mode t)
 '(global-display-line-numbers-mode t)
 '(package-selected-packages
   (quote
    (web-mode virtualenvwrapper use-package smex smartparens shell-split-string servant realgud python-mode pyenv-mode py-autopep8 projectile prodigy popwin plantuml-mode pallet org-ac nyan-mode multiple-cursors markdown-mode magit json-mode jedi init-loader ido-completing-read+ idle-highlight-mode htmlize helm-pydoc helm-gtags groovy-mode groovy-imports graphene-meta-theme gradle-mode go-playground go-impl go-errcheck go-eldoc go-dlv go-autocomplete gited git ggtags flymake-python-pyflakes flymake-cursor flycheck-cask expand-region exec-path-from-shell ert-runner ert-async ensime elpy el-mock ecukes ecb drag-stuff diminish anaconda-mode)))
 '(save-place t)
 '(show-paren-mode t)
 '(size-indication-mode t))

(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
