;;
;; My own setting
;;

(require 'cask "$HOME/.cask/cask.el")
(cask-initialize)
; (setq load-path (nconc '("~/.emacs") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정
; (setq load-path (nconc '("~/.emacs.d/lisp") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정

(add-to-list 'load-path "~/.emacs.d/lisp/")
;(require 'edit-server)
;(edit-server-start)
(when (locate-library "edit-server")
  (require 'edit-server)
  (setq edit-server-new-frame nil)
  (edit-server-start))

(add-hook 'edit-server-start-hook 'markdown-mode)

(autoload 'edit-server-maybe-dehtmlize-buffer "edit-server-htmlize" "edit-server-htmlize" t)
(autoload 'edit-server-maybe-htmlize-buffer   "edit-server-htmlize" "edit-server-htmlize" t)
(add-hook 'edit-server-start-hook 'edit-server-maybe-dehtmlize-buffer)
(add-hook 'edit-server-done-hook  'edit-server-maybe-htmlize-buffer)


(require 'npy)
(npy-initialize)
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))

;; Some people have reported problems when pasting from other OS X applications if they have set the command key as Meta, because Emacs always uses its internal killring for C-y etc. You may merge the Emacs kill-ring with the clipboard via:
(setq select-enable-clipboard t)

(require 'xcscope)
(define-key global-map [(control f3)]  'cscope-set-initial-directory)
(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
(define-key global-map [(control f5)]  'cscope-find-this-symbol)
(define-key global-map [(control f6)]  'cscope-find-global-definition)
(define-key global-map [(control f7)]
  'cscope-find-global-definition-no-prompting)
(define-key global-map [(control f8)]  'cscope-pop-mark)
(define-key global-map [(control f9)]  'cscope-history-forward-line)
(define-key global-map [(control f10)] 'cscope-history-forward-file)
(define-key global-map [(control f11)] 'cscope-history-backward-line)
(define-key global-map [(control f12)] 'cscope-history-backward-file)
(define-key global-map [(meta f9)]  'cscope-display-buffer)
(define-key global-map [(meta f10)] 'cscope-display-buffer-toggle)

(setq load-path (nconc '("~/.emacs.d/lisp") load-path))	;; 개인 lisp 패키지가 위치 할 load-path 설정
(setq load-path (nconc '("/usr/local/opt/global/share/gtags") load-path))
; (setq load-path (nconc '("/Volumes/PDS/Users/x/Works/ggtags") load-path))
;; =============================================================================


(setq frame-title-format
      (list (format "%s %%S: %%j " (system-name))
        '(buffer-file-name "%f" (dired-directory dired-directory "%b"))))

(defun set-win-key-bindings ()
  "Windows Keyboard key bindings"
  (interactive)
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
  )

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name)))

(global-set-key [C-f1] 'show-file-name) ; Or any other key you want

; for cscope
(require 'xcscope)
(setq cscope-do-not-update-database t)
(add-hook 'java-mode-hook (function cscope:hook))

; (require 'hanja-util)

;; =============================================================================
;; person info
;; =============================================================================
(setq user-full-name "Nate Doohyun Jang")
(setq user-mail-address "dh.jang@gmail.com")

;; =============================================================================
;; 기본 색 지정
;; =============================================================================
(set-foreground-color "wheat")
(set-background-color "DarkSlateGray")

;; =============================================================================
;; 영역 색 지정
;; =============================================================================
(set-face-foreground 'region "white")
(set-face-background 'region "cadetblue")

;; =============================================================================
;; 한글 세벌식 최종
;; =============================================================================
;; (require 'hangul)
(set-input-method "korean-hangul3f") ;; if you want 3 beolsik final...
;; (utf-translate-cjk-mode 1)
(prefer-coding-system 'utf-8)

;;모드라인에 현재 커서의 줄과 칼럼위치 시간 표시('mode line hacking'때문에 필요 없음)
(setq column-number-mode t)             ;;컬럼수를 모드라인에 표시할 경우 에디팅 속도가 느려진다

;; function to reload .emacs 2008.01.24
;; 출처 : http://hermian.tistory.com/195
(defun reload-dotemacs ()
  "Reload .emacs"
  (interactive)
  (load-file "~/.emacs"))

; for emacsclient
(server-start)

;; Switch fromm *.<impl> to *.<head> and vice versa
(defun switch-cc-to-h ()
  (interactive)
  (when (string-match "^\\(.*\\)\\.\\([^.]*\\)$" buffer-file-name)
	(let ((name (match-string 1 buffer-file-name))
		  (suffix (match-string 2 buffer-file-name)))
	  (cond ((string-match suffix "c\\|cc\\|C\\|cpp")
			 (cond ((file-exists-p (concat name ".h"))
					(find-file (concat name ".h"))
					)
				   ((file-exists-p (concat name ".hh"))
					(find-file (concat name ".hh"))
					)
				   ))
			((string-match suffix "h\\|hh")
			 (cond ((file-exists-p (concat name ".cc"))
					(find-file (concat name ".cc"))
					)
				   ((file-exists-p (concat name ".C"))
					(find-file (concat name ".C"))
					)
				   ((file-exists-p (concat name ".cpp"))
					(find-file (concat name ".cpp"))
					)
				   ((file-exists-p (concat name ".c"))
					(find-file (concat name ".c"))
					)))))))

;; ================================================================================
;; auto mode alist
;; ================================================================================
;;(setq-default auto-fill-function 'do-auto-fill)		;; auto-fill모드 설정
(autoload 'x-resource-generic-mode "generic-x" nil t)	;; generic-x 모드 설정
(setq auto-mode-alist
      (nconc '(("\\.ml[iylp]?\\'" . caml-mode)
               ("\\.sml\\'" . sml-mode)
               ("\\.grm\\'" . sml-mode)
               ("\\.ML\\'" . sml-mode)
               ("\\.htm\\'" . html-helper-mode)
               ("\\.html\\'" . html-helper-mode)
               ("\\.shtml\\'" . html-helper-mode)
               ("\\.thtml\\'" . html-helper-mode)
               ("\\.css\\'" . css-mode)
               ("\\.php\\'" . php-mode)
               ("\\.php3\\'" . php-mode)
               ("\\.gnus\\'" . emacs-lisp-mode)
               ("\\.abbrev_defs\\'" . emacs-lisp-mode)
               ("\\el\\'" . emacs-lisp-mode)
               ("\\.s?html\\'" . sgml-mode)
               ("\\.sgml\\'" . sgml-mode)
               ("\\.tex\\'" . latex-mode)
               ("\\.ks$\\'" . latex-mode)
               ("\\.cl\\'" . lisp-mode)
               ("\\.cgi\\'" . cperl-mode)
               ("\\.pl\\'" . cperl-mode)
               ("\\.pm\\'" . cperl-mode)
               ("\\.py\\'" . python-mode)
               ("\\.c\\'" . c-mode)
               ("\\.C\\'" . c-mode)
               ("\\.cc\\'" . c++-mode)
               ("\\.cpp\\'" . c++-mode)
               ("\\.h\\'" . c++-mode)
               ("\\.hh\\'" . c++-mode)
               ("\\.idl\\'" . c++-mode)
               ("\\.txi\\'" . Texinfo-mode)
               ("\\.java\\'" . java-mode)
               ("\\.prolog\\'" . prolog-mode)
               ("\\.pro\\'" . prolog-mode)
               ("\\.txt\\'" . text-mode))
             auto-mode-alist))

;; ================================================================================
;; C mode
;; ================================================================================
(add-hook 'c-mode-common-hook
          '(lambda()
            (c-set-style "k&r") ;;C 코딩 스타일 정의
			(gtags-mode 1)
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))
))

(add-hook 'c++-mode-common-hook
          '(lambda()
            (c-set-style "k&r") ;;C 코딩 스타일 정의
			(gtags-mode 1)
			(when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))
))

;; revert buffer. 파일 내용이나 디렉토리 내용이 바뀌어서 Disk의 내용을 다시 불러올때
;; g : dired 모드에서 사용
;; M-x revert-buffer RET yes RET
;; C-x C-v RET

(defun revert-all-buffers()
  "Refreshs all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
		 (buffer (car list)))
	(while buffer
	  (if (string-match "\\*" (buffer-name buffer))
	      (progn
	        (setq list (cdr list))
	        (setq buffer (car list)))
		(progn
		  (set-buffer buffer)
		  (revert-buffer t t t)
		  (setq list (cdr list))
		  (setq buffer (car list))))))
  (message "Refreshing open files"))

;; ================================================================================
;; show paren mode. 괄호등을 사용할때 마지막에 사용된 괄호에 대응하는 괄호를 찾음
;; ================================================================================
(show-paren-mode 1)


(setq enable-recursive-minibuffers t)


;; ================================================================================
;; ;;indent with just spaces 들여쓰기 설정
;; ================================================================================
;;(setq-default indent-tabs-mode nil)   ;; nil 이 아니면 들여쓰기 명령이 탭문자를 입력한다.(버퍼지역변수)
(setq-default indent-tabs-mode t)		;; nil 이 아니면 들여쓰기 명령이 탭문자를 입력한다.(버퍼지역변수)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 26 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))
(setq default-tab-width 4)              ;; 탭간 간격(버퍼지역변수)
;; automatically indenting yanked text if in programming-modes
;; 붙여넣기 하면서 자동 들여쓰기 함수
(defadvice yank (after indent-region activate)
  (if (member major-mode '(emacs-lisp-mode
                           c-mode c++-mode
                           tcl-mode sql-mode
                           perl-mode cperl-mode
                           java-mode jde-mode
                           LaTeX-mode TeX-mode))
	  (let ((transient-mark-mode nil))
		(indent-region (region-beginning) (region-end) nil))))


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
 '(font-use-system-font t)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Hack" :foundry "unknown" :slant normal :weight normal :height 120 :width normal)))))

;; http://www.emacswiki.org/emacs/CollectionOfEmacsDevelopmentEnvironmentTools
;; 6. While I was at it, I installed Exuberant Ctags using MacPorts and enabled it in CEDET::
;;
;(semantic-load-enable-primary-exuberent-ctags-support)

;(require 'semantic/ia)
;(require 'semantic/bovine/gcc)

; (load-file "/Applications/MacPorts/EmacsMac.app/Contents/Resources/lisp/cedet/cedet.elc")
;(global-ede-mode 1)                      ; Enable the Project management system
;(require 'semantic/sb)
;(semantic-mode 1)
; (semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
; (global-srecode-minor-mode 1)            ; Enable template insertion menu
;; ================================================================================
;; 검색및 치환을 할때 찾은 문자열을 표시되게 함
;; ================================================================================
(setq search-highlight t)
(setq query-replace-highlight t)

;(setq-mode-local c-mode semanticdb-find-default-throttle
;                 '(project unloaded system recursive))
										; One of my recent favorite pieces of Emacs configuration. The % command was one of the things I missed the
										; most in Emacs, until I found this little gem. I modified it from its original source by adding
										; previous-line and next-line to the list of commands.
										; From http://www.emacswiki.org/emacs/ParenthesisMatching#toc4
(defun goto-match-paren (arg)
  "Go to the matching parenthesis if on parenthesis AND last command is a movement command, otherwise insert %.
vi style of % jumping to matching brace."
  (interactive "p")
  (message "%s" last-command)
  (if (not (memq last-command '(
                                set-mark
                                cua-set-mark
                                goto-match-paren
                                down-list
                                up-list
                                end-of-defun
                                beginning-of-defun
                                backward-sexp
                                forward-sexp
                                backward-up-list
                                forward-paragraph
                                backward-paragraph
                                end-of-buffer
                                beginning-of-buffer
                                backward-word
                                forward-word
                                mwheel-scroll
                                backward-word
                                forward-word
                                mouse-start-secondary
                                mouse-yank-secondary
                                mouse-secondary-save-then-kill
                                move-end-of-line
                                move-beginning-of-line
                                backward-char
                                forward-char
                                scroll-up
                                scroll-down
                                scroll-left
                                scroll-right
                                mouse-set-point
                                next-buffer
                                previous-buffer
								previous-line
								next-line
                                )
                 ))
      (self-insert-command (or arg 1))
    (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
          ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
          (t (self-insert-command (or arg 1))))))
(global-set-key (kbd "%") 'goto-match-paren)

;; Make Command act as Meta, Option as Alt,
;; right-Option as Super
; (setq mac-command-modifier 'alt)
; (setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'super)

;; if you want to enable support for gnu global
;(when (cedet-gnu-global-version-check t)
;  (semanticdb-enable-gnu-global-databases 'c-mode)
;  (semanticdb-enable-gnu-global-databases 'c++-mode))
;; Key bindings
;;(osx-key-mode -1)  ; no Mac-specific key bindings
;; (setq x-alt-keysym 'meta)
;; key bindings
;(when (eq system-type 'darwin) ;; mac specific settings
;  (setq mac-option-modifier 'alt)
;  (setq mac-command-modifier 'meta)
;  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
;  )

;; enable ctags for some languages:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;(when (cedet-ectag-version-check)
;  (semantic-load-enable-primary-exuberent-ctags-support))
;; If you want to use the option key to enter special characters (such as £) instead of functioning as Alt of Meta, you can specify this in your ~/.emacs:
; (setq mac-option-modifier nil)

(add-to-list 'load-path "/Users/x/.emacs/dash-at-point")
(autoload 'dash-at-point "dash-at-point"
  "Search the word at point with Dash." t nil)
(global-set-key "\C-cd" 'dash-at-point)
;; if you instead decide to leave osx-key-mode on:

;(add-to-list 'dash-at-point-mode-alist '(perl-mode . "perl"))
;(add-to-list 'dash-at-point-mode-alist '(c++-mode . "cpp"))
;(add-to-list 'dash-at-point-mode-alist '(c-mode . "c"))

;(add-hook 'rinari-minor-mode-hook
;          (lambda () (setq dash-at-point-docset "rails")))
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
  
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
		((looking-at "\\s\)") (forward-char 1) (backward-list 1))
		(t (self-insert-command (or arg 1)))))

;; ISO 8601 Format yyyy-mm-dd, http://ergoemacs.org/emacs/elisp_datetime.html 
(defun insert-date ()
  "Insert current date yyyy-mm-dd."
  (interactive)
  (when (region-active-p)
    (delete-region (region-beginning) (region-end) )
    )
  (insert (format-time-string "%Y-%m-%d"))

;; example of setting env var named “path”, by appending a new path to existing path
(setenv "PATH"
		(concat
		 "/usr/local/bin" ":"
		 "/usr/local/sbin" ":"
		 (getenv "PATH")
		 )
		)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
              (ggtags-mode 1))))

(setq tramp-default-method "ssh")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://github.com/fgallina/python.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/.emacs.d/lisp") ;; user-emacs-directory)
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
;; for gtags

(autoload 'gtags-mode "gtags" "" t)
;; Global font-lock mode 
(global-font-lock-mode 1) 
;; 
;(init-loader-load "~/.emacs.d/init-loader/")

(add-hook 'gtags-mode-hook
  '(lambda ()
     (define-key gtags-mode-map "\C-f" 'scroll-up)
     (define-key gtags-mode-map "\C-b" 'scroll-down)
))
;; Pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)
))
;; https://github.com/jorgenschaefer/elpy
(package-initialize)
(elpy-enable)
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/"))

(setq gtags-suggested-key-mapping t)
(setq gtags-auto-update t)
(require 'package)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(require 'tabbar)
(tabbar-mode t)
(setq tabbar-cycle-scope 'tabs)
(setq tabbar-buffer-groups-function
      (lambda ()
	(let ((dir (expand-file-name default-directory)))
	  (cond ((member (buffer-name) '("*Completions*"
					 "*scratch*"
					 "*Messages*"
					 "*Ediff Registry*"))
		 (list "#misc"))
		((string-match-p "/.emacs.d/" dir)
		 (list ".emacs.d"))
		(t (list dir))))))
(setenv "PATH" "/usr/local/bin:/usr/bin:/bin:/Volumes/PDS/SystemRoot/usr/local/bin:/Volumes/PDS/SystemRoot/usr/local/sbin")
(setq exec-path (split-string (getenv "PATH") path-separator))

(setq python-shell-interpreter "ipython"
	  python-shell-interpreter-args "-i")
;; =============================================================================
;; 새로운 프레임 생성시 크기 설정
;; =============================================================================
(setq initial-frame-alist '((width . 160) (height . 100))) ;; 첫번째 프래임의 크기를 설정
(setq default-frame-alist '((width . 160) (height . 100))) ;; 그 다음 프래임의 크기를 설정

(require 'mmm-mode)
(setq mmm-global-mode 'maybe)

(defun my-mmm-markdown-auto-class (lang &optional submode)
  "Define a mmm-mode class for LANG in `markdown-mode' using SUBMODE.
If SUBMODE is not provided, use `LANG-mode' by default."
  (let ((class (intern (concat "markdown-" lang)))
        (submode (or submode (intern (concat lang "-mode"))))
        (front (concat "^```" lang "[\n\r]+"))
        (back "^```"))
    (mmm-add-classes (list (list class :submode submode :front front :back back)))
    (mmm-add-mode-ext-class 'markdown-mode nil class)))

;; Mode names that derive directly from the language name
(mapc 'my-mmm-markdown-auto-class
      '("awk" "bibtex" "c" "cpp" "css" "html" "latex" "lisp" "makefile"
        "markdown" "python" "r" "ruby" "sql" "stata" "xml"))

;; Mode names that differ from the language name
(my-mmm-markdown-auto-class "fortran" 'f90-mode)
(my-mmm-markdown-auto-class "perl" 'cperl-mode)
(my-mmm-markdown-auto-class "shell" 'shell-script-mode)

(setq mmm-parse-when-idle 't)

(global-set-key (kbd "C-c m") 'mmm-parse-buffer)

(put 'downcase-region 'disabled nil)


(require 'package)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("org" . "http://orgmode.org/elpa/")
                         ("marmalade" . "https://marmalade-repo.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

