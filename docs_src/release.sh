vue build && rm -rf ../docs && mv dist ../docs
gsed -i 's#=/#=#g' ../docs/index.html
git add ../docs ../docs_src
git commit -m "readme updates"
git push

