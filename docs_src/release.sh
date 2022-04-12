vue build && rm -rf ../docs && mv dist ../docs
gsed -i 's#=/#=#g' ../docs/index.html # make the included files work for localhost as well as at /dotfiles/
git add ../docs ../docs_src
git commit -m "readme updates"
git push

