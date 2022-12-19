<template lang="pug">
body
  .pizza.is-hidden-mobile
    a(href="https://www.paypal.me/AndyGrabow/3", target="_blank")
      img(src="pizza.png")
      div
        span If you like it
        br
        span buy me a pizza :)

  .container
    .section
      h1.title.marginless dotfiles
        a(
          href="https://github.com/kakulukia/dotfiles",
          title="Go to the GitHub-Repo"
        )
          img.github(src="github.png")
      a.claim(href="https://ohmyz.sh/", target="_blank") Your terminal never felt #[i this] good before.™
    .section
      asciinema-player#player.is-hidden-mobile(
        v-pre,
        src="demo.cast",
        poster="npt:0:01",
        speed="1.5",
        idle-time-limit="1"
      )
      iframe.is-hidden-tablet(
        width="560",
        height="315",
        src="https://www.youtube.com/embed/nkT3tQFLddU?VQ=HD720",
        frameborder="0",
        allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture",
        allowfullscreen
      )

      h2.subtitle Intro
      p.
        For the last several years (initial commit 2014-10-04) I have been building up my shell environment and it's the
        first thing that gets installed on a new server or Mac. Especially fasd and the reverse
        history search is a huge time saver.
      p.
        Some of this stuff I didn't even know was possible before I switched to ZSH or
        found app X, so I just wanted to share the whole collection. I did a few improvements myself,
        but basically it was all out there. This repo enables everybody to get all the goodies at
        once and helps me to feel at home, whenever I open a new shell. 😎

      h2.subtitle Installation
      p.
        Be sure you are logged in as the user for whom you want to install this shell
        package and that the user has sudo rights. On OSX also make sure that #[a(href="https://brew.sh/") homebrew] is installed.

      .install.is-hidden-mobile
        img(src="install_dotfiles.png")
        .command-line
          p
            span.command curl
            span.text  "https://raw.githubusercontent.com/kakulukia/dotfiles/main/misc/setup.sh"
            span  |
            span.command  bash

          span.icon.copy(@click="copyInstallCommand")
            i.mdi.mdi-content-copy

      img.is-hidden-tablet(src="install-mobile.png")
      p.
        This will install the following:
      span.icon
        i.mdi.mdi-signal-4g.mdi-light

      ul
        li GIT to be able to download the repo itself
        li ZSH as your new default shell
        li prezto
        li Python3 (ghar is a Python script)
        li ghar for managing the dotfiles itself (links everything into your home folder)
        li SpaceVim
        li fasd
        li fzf - mainly for completion
        li some handy aliases
        li starship

      p.
        #[strong Note:] Use the #[span.command ~/.gitconfig-personal] file to set your git username.
        That file is imported in #[span.command .gitconfig] so that settings can be ported via this
        repo, but the username stays personal.

      p In the misc folder you can find:
      ul
        li the Powerline patched SourceCode font (you may use any #[a(href="https://www.nerdfonts.com/" target="_blank") Nerdfont])
        li my currently used Dracula.itermcolors
        li better-osx-settings script
        li.
          an opinionated set of tools (#[a(href="https://github.com/kakulukia/dotfiles/blob/master/misc/essentials.txt") these] and
          #[a(href="https://github.com/kakulukia/dotfiles/blob/master/misc/additional-stuff.sh") those])

      p The dotfiles repo can be updated with the #[span.command update-dotfiles] alias.

      h2.subtitle Features
      p Apart from what's shown in the recording, here is some more of what's included:
      ul
        li suggestions (grey text) - use the right arrow key to accept
        li history reverse search - use the up arrow to cycle through previous commands.
          |
          | Anything you typed before hitting up will be used as filter and highlighted.
          |
          | This seriously saves a lot of typing. 😇
          br
          br
          figure
            img(src="history.png" title="context sensitive history search")
            figcaption migr + up arrow
        li red / green colored commands - shows that the command is (un)available
        li . is in the path so no need for any ./ prefixing executables
        li path
          ul
            li print a sorted version of $PATH
            li add the given folder to $PATH and
            li append the given path to your .profile when called with #[span.command path --save DIR]
        li mv - no need to type the file name twice for renaming
        li top - is aliased to glances if installed
        li ctop - for docker containers
        li ,, - jump to the git root dir
        li o - will open the finder in the current directory
        li
          a(href="https://github.com/kakulukia/dotfiles/tree/master/bin") cd to.app
          |  - there is an app in the bin folder that provides a
          | way to reverse the above trick and open a terminal at the current finder location.
          | Use the command key to just drag it into the finders toolbar.
          br
          br
          figure
            img(src="cdto.png" title="cdto in the finder")
            figcaption The result will look like this
        li
          a(
            href="https://github.com/kakulukia/dotfiles/tree/master/misc/QuickLook"
          ) QuickLook Plugins
          |  - there are a few collected plugins for OSX to preview some more files like Markdown
        li tm - there's a tmux theme and tm will reconnect to to your last session or create a new one
          br
          | I also changed the default prefix to CTRL+SPACE for easier usage.
        li diff - aliased to diff-so-fancy in general, not just the git version
        li co - use fasd to launch any known file in VS Code
        li errorcode - in general I don't see the point in displaying the error code
          | , hence the sad smiley in the prompt, but if you really wanna know, use that alias (unless you can remember the #?)
        li ips - will show all local ips (IPV4) / ip will show some info about your external one
        li ping - is aliased to prettyping
        li go-reload - hot reload for go apps you are working on
        li mgs - multi git status - if your company/current project totally embraces micro services (🙈)
          |  this might come in handy to update em all in one go
        li rg - alias for "rg -S --max-columns 444" won't clutter the screen with nasty one line files
        li customize startship.toml to create a custom prompt
        li up - that's the live preview pipe thing you saw at the end of the screencast. It's activated with CTRL+P for pipe.
        li and much more .. but that's about the stuff I frequently use :)

      h2.subtitle ToDo
      ul
        li colorls is a lil slow - there is a promising alternative, but
          a(href="https://github.com/Peltoche/lsd/issues/92" target="_blank")  it's not looking sexy yet
        li Decoupling this shell from needing Python. I am a Python developer, but sure it's
          |  not really needed for the shell itself. Currently the sync tool ghar is a Python script, tho.
        li This
          a(href="https://www.atlassian.com/git/tutorials/dotfiles" target="_blank")  trick
          |  looked kinda nice, i tried it, but it looked and felt messy. 🙄
          br
          | Im probably going to create a shell script to link my files the the HOME directory.
        li I tried zinit and zplug, but both failed to just work without extensive care. :/
          br
          | But the current startup speed is not that bad:
          figure
            img(src="benchmark.png" title="startup benchmark")
            figcaption current startup speed with all features enabled

      h2.subtitle Credits
      p
        | This theme was inspired by
        a(
          href="https://github.com/Bash-it/bash-it/blob/master/themes/powerline-plain/powerline-plain.theme.bash" target="_blank"
        )  PowerlinePlain
        |  and based on
        a(href="https://github.com/caiogondim/bullet-train-oh-my-zsh-theme" target="_blank")  BulletTrain
        | .
        br
        br
        strong Generally:
        |  Mad props to all awesome devs who build most of the apps referenced here.
        | Too many to list em all, but most if not all do feature a credit line inside the scripts.
</template>

<script>
export default {
  mounted() {
    let asciinema = document.createElement("script");
    asciinema.setAttribute("src", "asciinema-player.js");
    document.head.appendChild(asciinema);
  },
  methods: {
    copyInstallCommand () {
      navigator.clipboard.writeText('curl "https://raw.githubusercontent.com/kakulukia/dotfiles/main/misc/setup.sh" | bash')
    }
  }
};
</script>

<style lang="sass">
@font-face
  font-family: SauceCodePro
  src: url(assets/SauceCodePro.ttf)

a
  color: #8a56df
  &:hover
    color: #8a56df
    text-decoration: underline

.install
  margin: 2em 0
  position: relative
  .command-line
    position: absolute
    top: calc(50% - 10px)
    width: 100%
    display: grid
    grid-template-columns: 1fr 20px
    padding: 0 12px
  p
    font-size: 16px
    .command
      background: none
      color: #70865B
      padding: 0
    .text
      color: #A99367
    span
      color: white

  .icon.copy
    color: rgba(255, 255, 255, 0.38)
    cursor: pointer
    &:hover
      color: white

body::-webkit-scrollbar
  width: 10px
body::-webkit-scrollbar-thumb
  background-image: url(../public/scrollbar.png)

iframe
  width: 100%
  display: block

body, .asciinema-terminal
  font-family: "SauceCodePro", serif

h1.title.marginless
  margin-bottom: 0
.claim
  color: #4a4a4a
  i
    font-weight: bold
    /*color: #c5d928*/

.section + .section
  padding-top: 0
img.github
  height: 30px
  margin-left: 10px
  position: relative
  top: 4px
.pizza
  height:
  z-index: 1
  position: absolute
  top: 20px
  right: -185px
  a
    display: flex
    align-items: center
    color: #cd4d4c
    img
      height: 50px
    div
      margin: 0 20px 0 25px
      transition: ease-in-out 0.2s
  &:hover
    right: 0

figure
  display: block
  margin: 1em auto
  text-align: center
  figcaption
    font-size: 0.7em

span.command
  background: #eee
  font-style: italic
  padding: 0 5px

ul
  margin-bottom: 1em
  li:before
    content: "> "
    font-weight: bold
    margin-left: -20px
  li
    padding-left: 30px

p
  margin-bottom: 0.5em

h1, h2, h3
  border-bottom: 1px solid #eaecef
h2, h3
  margin-top: 2em

.asciinema-player .control-bar, .asciinema-theme-asciinema .asciinema-terminal
  background: #282a36
  border-color: #282a36

.asciinema-theme-asciinema
  .fg-1
    color: #AB6053
  .fg-2
    color: #70865B
  .fg-4
    color: #5E70A4
  .fg-6
    color: #A99367
  .fg-8
    color: #9c9c9c
  .fg-9
    color: #AB2C1D
  .fg-10
    color: #44973C
  .bg-52
    background: #571106
  .bg-22
    background: #275D17
  .fg-146
    color: #AFB0D4
  .bg-1
    background: #AB6052
  .fg-12
    color: #90ACF3
  .bg-2
    background: #70875B
  .bg-3
    background: #A67542
  .bg-4
    background: #5D70A5

@media (max-width: 821px)
  .install p
    font-size: 13px
@media (min-width: 822px) and (max-width: 1020px)
  .install p
    font-size: 14px

.asciinema-player .start-prompt .play-button div span
  display: flex
  align-items: center
  margin: 0 auto
  justify-content: center
</style>
