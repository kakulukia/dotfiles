<template lang="pug">
  body
    .container.is-hidden-desktop
      .section
        h1.title dotfiles
        p.
          This is a not meant for mobile .. please come back with a higher resolution. :)
    .container.is-hidden-touch
      .section
        h1.title dotfiles
      .section
        asciinema-player(v-pre id="player" src="demo.cast" poster="npt:0:01" speed="1.5" idle-time-limit="1")
        h2.subtitle Intro
        p.
          For the last 5 years I have been building up my shell environment and its the
          first thing that gets installed on a new server or Mac. Especially fasd and the reverse
          history search is a huge time saver.
        p.
          Some of this stuff I didn't even know was possible before I switched to ZSH or
          found app X, so i just wanted to share the whole collection.
        h2.subtitle Installation
        p.
          Be sure you are logged in as the user for whom you want to install this shell
          package and that the user has sudo rights.
        .install
          img(src="install_dotfiles.png")
          p
            span.command curl
            span.text  "https://raw.githubusercontent.com/kakulukia/dotfiles/master/misc/setup.sh"
            span  |
            span.command  sh
        p.
          This will install the following:
        ul
          li GIT to be able to download the repo itself
          li ZSH as your new default shell
          li oh my zsh
          li ghar for managing the dotfiles itself (links everything into your home folder)
          li SpaceVim
          li fasd
          li some handy aliases

        p.
          #[strong Note:] Use the #[span.command ~/.gitconfig-personal] file to set your git username.
          That file is imported in #[span.command .gitconfig] so that settings can be ported via this
          repo, but the username stays personal.

        p In the misc folder you can find:
        ul
          li the Powerline patched SourceCode font (you may use any #[a(href="https://www.nerdfonts.com/") Nerdfont])
          li my currently used Sundried.itermcolors
          li better-osx-settings script
          li.
            an opinionated set of tools (#[a(href="https://github.com/kakulukia/dotfiles/blob/master/misc/essentials.txt") these] and
            #[a(href="https://github.com/kakulukia/dotfiles/blob/master/misc/additional-stuff.sh") those])

        p The dotfiles repo can be updated with the #[span.command update-dotfiles] alias.


</template>

<script>
export default {
  mounted () {
    let asciinema = document.createElement('script')
    asciinema.setAttribute('src', 'asciinema-player.js')
    document.head.appendChild(asciinema)
  }
}


</script>

<style lang="sass">

@font-face
  font-family: SauceCodePro
  src: url(SauceCodePro.ttf)

body, .asciinema-terminal
  font-family: "SauceCodePro"

.section + .section
  padding-top: 0

span.command
  background: #eee
  font-style: italic
  padding: 0 5px

ul
  margin-bottom: 1em
  li:before
    content: "> "
    font-weight: bold
    margin-left: -17px
  li
    padding-left: 30px

.install
  margin: 2em 0
  position: relative
  p
    position: absolute
    top: 42%
    left: 18px
    font-size: 21px
    .command
      background: none
      color: #70865B
    .text
      color: #A99367
    span
      color: white
p
  margin-bottom: 0.5em

h1, h2, h3
  border-bottom: 1px solid #eaecef
h2, h3
  margin-top: 2em
//#player
  width: 894px
  height: 492px
  background: black

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

@media (max-width: 1215px)
  .install p
    font-size: 17px
</style>
