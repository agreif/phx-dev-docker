FROM elixir:latest

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y \
       apt-utils \
       build-essential \
       inotify-tools \
       emacs-nox

ENV USER="dev"

RUN \
  addgroup \
   --gid 1000 \
   "${USER}" \
  && useradd \
   -s /bin/bash \
   -u 1000 \
   -g "${USER}" \
   -d "/home/${USER}" \
   -m \
   "${USER}"\
  && su "${USER}"

RUN mkdir -p /home/${USER}/.emacs.d && chown "${USER}":"${USER}" /home/${USER}/.emacs.d

RUN echo "\n\
(custom-set-variables\n\
 '(backup-by-copying t)\n\
 '(blink-cursor-mode nil)\n\
 '(ediff-split-window-function (quote split-window-horizontally))\n\
 '(inhibit-startup-screen t)\n\
 '(line-move-visual nil)\n\
 '(make-backup-files nil)\n\
 '(menu-bar-mode nil)\n\
 '(require-final-newline t)\n\
 '(scroll-bar-mode nil)\n\
 '(show-paren-mode t)\n\
 '(show-trailing-whitespace t)\n\
 '(vc-follow-symlinks t))\n\
(fset 'yes-or-no-p 'y-or-n-p)\n\
(global-auto-revert-mode 1)\n\
(put 'set-goal-column 'disabled nil)\n\
(put 'upcase-region 'disabled nil)\n\
(put 'downcase-region 'disabled nil)\n\
(put 'narrow-to-region 'disabled nil)\n\
\n\
(setq vc-handled-backends nil)\n\
\n\
(setq message-kill-buffer-on-exit t)\n\
\n\
(setq create-lockfiles nil)\n\
\n\
(setq custom-file (expand-file-name \"custom.el\" user-emacs-directory))\n\
(when (file-exists-p custom-file)\n\
  (load custom-file))\n\
\n\
;; (require 'package)\n\
;; (add-to-list 'package-archives '(\"melpa\" . \"https://melpa.org/packages/\") t)\n\
;; (add-to-list 'package-archives '(\"gnu\" . \"https://elpa.gnu.org/packages/\") t)\n\
;; (package-initialize)\n\
;; (package-refresh-contents)\n\
;; (package-install 'alchemist)\n\
;; (package-install 'elixir-mode)\n\
;; (package-install 'flycheck-elixir)\n\
;; (package-install 'magit)\n\
;; (package-install 'pabbrev)\n\
\n\
(require 'magit)\n\
(global-set-key (kbd \"C-x g\") 'magit-status)\n\
(global-set-key (kbd \"C-x M-g\") 'magit-dispatch-popup)\n\
\n\
(fset 'dupl-line\n\
   \"\C-a\C-@\C-n\C-[w\C-y\C-p\C-e\")\n\
(global-set-key (kbd \"C-x C-k 1\") 'dupl-line)\n\
\n\
(fset 'f1\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF1^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-1\") 'f1)\n\
(fset 'f2\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF2^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-2\") 'f2)\n\
(fset 'f3\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF3^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-3\") 'f3)\n\
(fset 'f4\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF4^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-4\") 'f4)\n\
(fset 'f5\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF5^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-5\") 'f5)\n\
(fset 'f6\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF6^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-6\") 'f6)\n\
(fset 'f7\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF7^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-7\") 'f7)\n\
(fset 'f8\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF8^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-8\") 'f8)\n\
(fset 'f9\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF9^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-9\") 'f9)\n\
(fset 'f0\n\
   (lambda (&optional arg) \"Keyboard macro.\" (interactive \"p\") (kmacro-exec-ring-item (quote (\"^[xselect-frame-by-name^MF0^M\" 0 \"%d\")) arg)))\n\
(global-set-key (kbd \"M-0\") 'f0)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(make-frame-command)\n\
(f1)\n\
"\
> /home/${USER}/.emacs

RUN echo "\n\
alias ll=\"ls -la\"\n\
alias S=\"tmux new\"\n\
alias r=\"tmux attach -d\"\n\
alias x=\"tmux attach\"\n\
alias gitc=~/bin/git_ci.sh\n\
alias gitcp=~/bin/git_ci_push.sh\n\
alias green=\"echo -e '\e]11;rgb:2f/4f/4f\a'\"\n\
alias red=\"echo -e '\e]11;rgb:8b/00/00\a'\"\n\
alias yellow=\"echo -e '\e]11;rgb:7e/7d/00\a'\"\n\
export EDITOR=emacs\n\
export GPG_TTY=$(tty)\n\
"\
>> /home/${USER}/.bashrc

RUN mix local.hex --force && \
    mix local.rebar --force

ENV APP_HOME /app
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME

EXPOSE 4000

CMD ["mix", "phx.server"]
