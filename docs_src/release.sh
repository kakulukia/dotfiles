vue build && rm -rf ../docs && mv dist ../docs
gsed -i 's#=/#=#g' ../docs/index.html 
